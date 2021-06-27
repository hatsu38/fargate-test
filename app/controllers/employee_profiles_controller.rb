class EmployeeProfilesController < ApplicationController
  before_action :authenticate_employee_authenticate!

  def index
    @employee_profiles = EmployeeProfile.all
  end

  def new
    @employee_profile = EmployeeProfile.new(employee_id: current_employee_authenticate.employee_id)
  end

  def create
    @employee_profile = EmployeeProfile.new(employee_profile_params)
    if @employee_profile.save
      redirect_to employees_path
    else
      render :new
    end
  end

  private

  def employee_profile_params
    params.require(:employee_profile).permit(:name).merge(employee_id: current_employee_authenticate.employee_id)
  end
end
