class CreateRuns < ActiveRecord::Migration[5.1]
  def change
    create_table :runs do |t|
      t.string :title
      t.integer :duration
      t.float :distance
      t.line_string :path, geographic: true
      t.timestamps
    end
  end
end
