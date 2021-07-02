module CulpritTracking
  extend ActiveSupport::Concern

  included do
    before_action :set_culprit_tracking
  end

  def set_culprit_tracking
    controller = request.env["action_controller.instance"]

    if controller.present?
      source_action = "#{controller.class.name}##{controller.action_name}"
      source_method = request.env["REQUEST_METHOD"]
      source_system = fetch_subsystem(controller)
      affected_user = fetch_audit_user(controller)
      ip            = request.headers["HTTP_X_REAL_IP"] || request.remote_ip
      referer       = request.referer
      user_agent    = request.user_agent

      RequestStore.store[:culprit_tracking] = {
        source_action: source_action,
        source_method: source_method,
        source_system: source_system,
        affected_user: affected_user ? "id:#{affected_user&.id} employee_id:#{affected_user&.employee_id}" : "unknown",
        ip: ip,
        referer: referer,
        user_agent: user_agent
      }
    end
  end

  private

  def fetch_subsystem(controller)
    controller.class.name.split("::").first
  end

  def fetch_audit_user(controller)
    controller.send(:current_employee_authenticate) if controller.respond_to?(:current_employee_authenticate, true)
  end
end
