# coding: utf-8
class ApiController < ApplicationController

  #helper_method [:restrict_access_user, :restrict_access_shop, :restrict_access_user_and_shop]

  #rescue_from Exception, with: :error500
  #rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :error404


  def error401(messages)
    render json: {
      message: 'Unauthorized',
      errors: messages
    }, status: 401
  end

  def error422(messages)
    render json: {
      message: 'Unprocessable Entity',
      errors: messages
    }, status: 422
  end

  def error403
    render json: {
      message: 'Forbidden'
    }, status: 403
  end

  def error404
    render json: {
      status: 404,
      message: 'Not Found'
    }, status: 404
  end

  def error500(e)
    render json: {
      status: 500,
      message: 'Internal Server Error'
    }, status: 500
  end

  private
    def restrict_access_user
      authenticate_or_request_with_http_token do |token, options|
        @token = token
        ApiKey.exists?(access_token: token)
      end
    end

    def restrict_access_shop
      authenticate_or_request_with_http_token do |token, options|
        @token = token
        ApiKeyForShop.exists?(access_token: token)
      end
    end

    def restrict_access_user_and_shop
      authenticate_or_request_with_http_token do |token, options|
        @token = token
        ApiKey.exists?(access_token: token) || ApiKeyForShop.exists?(access_token: token)
      end
    end

end
