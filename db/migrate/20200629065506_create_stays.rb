class CreateStays < ActiveRecord::Migration[6.0]
  def change
    create_table :stays do |t|
      t.date :start_date
      t.date :end_date
      t.references :tenant, null: false, foreign_key: true
      t.references :studio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
