module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from Pundit::NotAuthorizedError, with: :forbidden
  end

  private

  def record_not_found(exception)
    render json: { error: { code: 404, message: exception.message } }, status: :not_found
  end

  def record_invalid(exception)
    render json: { error: { code: 422, message: exception.message } }, status: :unprocessable_entity
  end

  def forbidden(exception)
    render json: { error: { code: 403, message: "Forbidden" } }, status: :forbidden
  end
end
