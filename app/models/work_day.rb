class WorkDay < ApplicationRecord
    belongs_to :employee
    has_many :workday_logs
end
