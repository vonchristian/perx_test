module Api
  module Users
    class RewardsController < Api::BaseController
      def index
        user = User.find_by(id: params[:user_id])
        return render json: { error: "User not found" }, status: :not_found unless user

        render json: RewardsSerializer.new(user.rewards).serializable_hash.to_json
      end

      def create
        user = User.find_by(id: params[:user_id])
        return render json: { error: "User not found" }, status: :not_found unless user

        rewards = Rewards::Award.run(user: user)

        if rewards.valid?
          render json: UsersSerializer.new(rewards.result).serializable_hash.to_json, status: :created
        else
          render json: { errors: rewards.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
