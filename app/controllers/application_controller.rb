class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  def login
  end

end
