class EmployeesController < ApplicationController
    before_action :authenticate_user!
    
    def import
        Employee.import_csv(params[:file])
        redirect_to root_path, notice: 'CSV file imported successfully'
    end
end
