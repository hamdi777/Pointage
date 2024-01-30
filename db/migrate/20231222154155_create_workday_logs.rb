class CreateWorkdayLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :workday_logs do |t|
      t.references :work_day
      t.time :log_time
      t.timestamps
    end
  end
end
