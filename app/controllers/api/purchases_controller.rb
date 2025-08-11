module Api
  class PurchasesController < Api::BaseController
    def create
      user = User.find_by(id: purchase_params[:user_id])
      return render json: { error: "User not found" }, status: :not_found unless user

      service = Purchases::Create.run(purchase_params.merge(user: user))
      if service.valid?
        render json: PurchaseSerializer.new(service.result).serializable_hash.to_json, status: :created
      else
        render json: { errors: service.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def purchase_params
      params.require(:purchase).permit(:user_id, :amount_cents, :country)
    end
  end
end
