Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new
  config.lograge.custom_options = lambda do |event|
    exceptions = %w(controller action format authenticity_token id)
    {
      time: Time.current,
      event_time: event.time,
      request_id: (event.payload[:headers].try(:env) || {})["action_dispatch.request_id"],
      exception: event.payload[:exception] || "",
      backtrace: event.payload[:exception_object].try(:backtrace).try(:join, "\n") || "",
      params: event.payload[:params]&.except(*exceptions)
    }.merge(RequestStore[:culprit_tracking] || {})
  end
end