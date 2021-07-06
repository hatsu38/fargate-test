class ApplicationController < ActionController::Base
  include CulpritTracking
  include ErrorsHandler
end
