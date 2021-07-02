class FargateTestLogger
  CONTROLLER_PARAMS_EXCEPTION = %w[controller action format authenticity_token].freeze

  def self.info(message: "", set_backtrace: false, context: {}, extra_context: {})
    self.logging(
      "info",
      nil,
      message: message,
      set_backtrace: set_backtrace,
      context: context,
      extra_context: extra_context
    )
  end

  def self.warn(exception, message: "", set_backtrace: false, context: {}, extra_context: {})
    self.logging(
      "warn",
      exception,
      message: message,
      set_backtrace: set_backtrace,
      context: context,
      extra_context: extra_context
    )
  end

  def self.error(exception, message: "", set_backtrace: false, context: {}, extra_context: {})
    self.logging(
      "error",
      exception,
      message: message,
      set_backtrace: set_backtrace,
      context: context,
      extra_context: extra_context
    )
  end

  def self.fatal(exception, message: "", set_backtrace: false, context: {}, extra_context: {})
    self.logging(
      "fatal",
      exception,
      message: message,
      set_backtrace: set_backtrace,
      context: context,
      extra_context: extra_context
    )
  end

  def self.logging(level, exception, message: "", set_backtrace: false, context: {}, extra_context: {})
    if set_backtrace && exception.present?
      exception.set_backtrace(caller)
    end
    if level == "error" || level == "fatal"
      Raven.extra_context(extra_context) do
        Raven.capture_exception(exception)
      end
    end

    controller = context["action_controller.instance"]
    controller_params = if controller.present?
                          (controller.params || {}).except(*CONTROLLER_PARAMS_EXCEPTION)
                        else
                          {}
                        end
    log = {
      method: context["REQUEST_METHOD"],
      path: context["REQUEST_URI"],
      params: controller_params,
      format: "json",
      time: Time.current,
      request_id: context["action_dispatch.request_id"],
      level: level,
      message: message,
      exception: exception,
      backtrace: exception&.backtrace&.join("\n")
    }.merge(RequestStore[:culprit_tracking] || {})
    Rails.logger.send(level, log.to_json)
  end
end
