class Run < ApplicationRecord
  validates :title, presence: true
  validates :duration, presence: true
  validates :distance, presence: true

  def self.matched id
    sql = <<-SQL
      WITH buffer AS (
          SELECT ST_Buffer(r.path, 5) as geom, id
          FROM runs r
          WHERE r.id = :run_id
        ),
        intersecting AS (
          SELECT
                r.*,
                ST_Intersection(r.path, b.geom) as geominter,
                ST_Length(r.path) as length_initial
          FROM runs r
          INNER JOIN buffer b
              ON ST_Intersects(r.path, b.geom)
          )
      SELECT *
      FROM intersecting AS i
      WHERE (ST_Length(geominter)*100)/length_initial > 90
      AND i.id != :run_id
    SQL
    self.find_by_sql([sql, {:run_id => id}])
  end
end
