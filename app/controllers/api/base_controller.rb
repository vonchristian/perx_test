class Api::BaseController < ActionController::API
  # Simple token authentication for client API calls
  before_action :authenticate_api_client!

  private

  def authenticate_api_client!
    token = request.headers["Authorization"]&.split(" ")&.last
    @current_client = ApiClient.find_by(api_key: token)
    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_client
  end

  def current_client
    @current_client
  end
end
