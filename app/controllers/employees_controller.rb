class EmployeesController < ApplicationController
  before_action :authenticate_employee_authenticate!

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new(employee_authenticate: current_employee_authenticate)
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employees_path
    else
      render :new
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name).merge(employee_authenticate: current_employee_authenticate)
  end
end
