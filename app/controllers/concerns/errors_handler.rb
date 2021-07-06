module ErrorsHandler
  extend ActiveSupport::Concern

  included do
    if Rails.env.production?
      rescue_from StandardError, with: :rescue_500
      rescue_from ActionController::RoutingError, with: :rescue_404
      rescue_from ActionView::MissingTemplate, with: :rescue_404
      rescue_from ActionController::UnknownFormat, with: :rescue_404
      rescue_from ActiveRecord::RecordNotFound, with: :rescue_404
    end
  end

  private

  def rescue_404(e)
    FargateTestLogger.warn(
      e,
      message: "404 NotFound #{request.fullpath} #{e.class}",
      context: request.env
    )
    render "errors/error_404.html.erb", status: :not_found
  end

  def rescue_500(e)
    FargateTestLogger.error(
      e,
      message: "500 InternalError #{request.fullpath} #{e.class}",
      context: request.env
    )

    if request.xhr?
      render json: {}, status: :internal_server_error
    else
      render "errors/error_500.html.erb", status: :internal_server_error
    end
  end
end
