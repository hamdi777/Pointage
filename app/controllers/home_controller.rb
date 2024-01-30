class HomeController < ApplicationController
    def index
        @employees = Employee.includes(:work_days)
        if params[:selected_month].present?
            @current_month = params[:selected_month].last(2).to_i
        else
            @current_month = Date.today.month
        end
    end
end
