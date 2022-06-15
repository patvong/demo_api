class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

  rescue_from Api::Errors::AuthenticationError, with: :deny_access

  def deny_access
    head :forbidden
  end

  private

  def authenticate
    return unless ActiveModel::Type::Boolean.new.cast(ENV["USE_AUTH"])

    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(token, ENV['BEARER_TOKEN'])
    end
  end
end
