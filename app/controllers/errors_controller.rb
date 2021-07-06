class ErrorsController < ApplicationController
  def not_found
    raise ActionController::RoutingError, "pathが正しくありません"
  end
end
