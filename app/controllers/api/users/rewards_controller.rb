module Api
  module Users
    class RewardsController < Api::BaseController
      def create
        user = User.find_by(id: params[:user_id])
        return render json: { error: "User not found" }, status: :not_found unless user

        rewards = Rewards::Create.run(user: user)

        if rewards.valid?
          render json: RewardsSerializer.new(rewards.result).serializable_hash.to_json, status: :created
        else
          render json: { errors: rewards.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
