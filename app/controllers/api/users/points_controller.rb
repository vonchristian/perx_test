module Api
  class Users::PointsController < Api::BaseController
    def index
      user = User.find_by(id: params[:user_id])
      return render json: { error: "User not found" }, status: :not_found unless user

      render json: PointLedgerSerializer.new(user.point_ledgers).serializable_hash.to_json
    end
  end
end
