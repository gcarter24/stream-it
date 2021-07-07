class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, if: -> { request.format.html? }

  def index
    render :file => "public/index.html"
  end
end
