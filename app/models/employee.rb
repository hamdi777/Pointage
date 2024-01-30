require 'csv'
class Employee < ApplicationRecord
    has_many :work_days

    def self.import_csv(file)
        CSV.foreach(file.path, headers: true) do |row|
            emp_name = row["User"].present? ? row["User"] : nil
            emp_code = row["WorkId"].present? ? row["WorkId"].to_i : nil
            date = row["Date"].present? ?  Date.parse(row["Date"]) : nil
            time = row["Time"].present? ?  Time.parse(row["Time"]) : nil
            if emp_name && emp_code && date && time
                emp = Employee.find_or_create_by(first_name: emp_name, e_code: emp_code)
                wd = WorkDay.find_or_create_by(employee_id: emp.id, day_date: date)
                wd.workday_logs.find_or_create_by(log_time: time)
                wd_logs = wd.workday_logs
                min_time = wd_logs.minimum(:log_time)
                max_time = wd_logs.maximum(:log_time)
                wd.update(start_time: min_time, end_time: max_time)
            end
        end
    end

    def month_workdays(month)
        if month == 1
            s_year = Date.today.year - 1
            e_year = Date.today.year
            s_month = 12
            e_month = month
        elsif month == 12
            s_year = Date.today.year
            e_year = Date.today.year + 1
            s_month = month - 1
            e_month = month
        else
            s_year = Date.today.year
            e_year = Date.today.year
            s_month = month - 1
            e_month = month
        end
        first_day_of_month = Date.new(s_year, s_month - 1, 23)
        last_day_of_month = Date.new(e_year, e_month, 24)
        work_days.where("day_date >= ? AND day_date <= ?", first_day_of_month, last_day_of_month)
    end
end
