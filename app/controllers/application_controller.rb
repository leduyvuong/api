class ApplicationController < ActionController::API

  before_action :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def secret_key
    "fooddrink"
  end
  
  def encode(payload)
    JWT.encode(payload, secret_key, "HS256")
  end

  def decode(token)
    begin
      JWT.decode(token, "fooddrink", true, {algorithm: "HS256"})[0]
    rescue
      "error"
    end
  end
end
