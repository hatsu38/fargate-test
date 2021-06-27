class EmployeeProfiles::LeavesController < ApplicationController
  before_action :authenticate_employee_authenticate!

  def destroy
    @employee_profile = EmployeeProfile.find(params[:employee_profile_id])
    employee = @employee_profile.employee
    ActiveRecord::Base.transaction do
      employee.leave!
      reset_session
    end
    redirect_to employee_profiles_path, notice: "退会完了しました"
  rescue => e
    redirect_to employee_profile_path(id: @employee_profile.id), alert: "退会に失敗しました"
  end
end
