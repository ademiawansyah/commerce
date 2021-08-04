# frozen_string_literal: true

class ApplicationController < ActionController::API
  # rescue_from StandardError, with: :error_500

  def error_500(exception)
    render json: { code: 500, messages: [:internal_server_error, exception.message] }, status: 500
  end

  def error_404(message = e.message)
    render json: {
      messages: [message],
      code: 404,
      data: {}
    }, status: 404
  end

  def error_400(message = [''])
    render json: {
      messages: message,
      code: 400,
      data: []
    }, status: 400
  end
end
