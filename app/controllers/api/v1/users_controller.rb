class Api::V1::UsersController < ApplicationController
  around_action :log_everything, only: :index

  def index
    @users = User.all
    # log_everything
    render json: @users
  end

  private
  def log_everything
    log_headers
    yield
  ensure
    log_response
  end

  def log_headers
    http_envs = {}.tap do |envs|
      request.headers.each do |key, value|
        envs[key] = value if key.downcase.starts_with?('http')
      end
    end

    Rails.logger.info "Received #{request.method.inspect} to #{request.url.inspect} from #{request.remote_ip.inspect}. Processing with headers #{http_envs.inspect} and params #{params.inspect}"
  end

  def log_response
    Rails.logger.info "Responding with #{response.status.inspect} => #{response.body.inspect}"
  end
end
