class CreateWorkDays < ActiveRecord::Migration[7.0]
  def change
    create_table :work_days do |t|
      t.references :employee
      t.date :day_date
      t.time :start_time
      t.time :start_lunch
      t.time :end_lunch
      t.time :end_time

      t.timestamps
    end

    add_index :work_days, [:employee_id, :day_date], unique: true
  end
end
