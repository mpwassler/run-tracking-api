class V1::RunsController < ApplicationController
  def index
    render json: Run.all
  end

  def show
    render json: Run.find(params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end

  def matched
    run = Run.find(params[:run_id])
    sql = <<-SQL
      WITH buffer AS (
          SELECT ST_Buffer(r.path, 5) as geom, id
          FROM runs r
          WHERE r.id = #{run.id}
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
      WHERE (ST_Length(geominter)*100)/length_initial > 75
      AND i.id != #{run.id}
    SQL

    matched_runs = Run.find_by_sql(sql)

    render json: matched_runs
  end

end
