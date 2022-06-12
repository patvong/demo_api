class ApplicationController < ActionController::API
  before_action :authenticate_bearer_token

  rescue_from Api::Errors::AuthenticationError, with: :deny_access

  def deny_access
    head :forbidden
  end

  private

  def authenticate_bearer_token
    return unless ActiveModel::Type::Boolean.new.cast(ENV["USE_AUTH"])

    raise Api::Errors::AuthenticationError.new unless bearer_token == ENV['BEARER_TOKEN']
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.authorization
    header.gsub(pattern, '') if header && header.match(pattern)
  end
end
