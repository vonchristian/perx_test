# spec/requests/api/users/points_spec.rb
require "rails_helper"

RSpec.describe "API::Users::Points", type: :request do
  let(:api_client) { FactoryBot.create(:api_client) }
  let(:headers) { { 'Authorization' => "Bearer #{api_client.api_key}", 'Content-Type' => 'application/json', 'Accept' => 'application/json' } }
  let(:user) { FactoryBot.create(:user) }
  let!(:reward1) { FactoryBot.create(:reward, user: user, reward_type: 'free_coffee') }
  let!(:reward2) { FactoryBot.create(:reward, user: user, reward_type: 'free_movie_tickets') }

  describe "GET /api/users/:user_id/rewards" do
    it "returns all rewards for the user" do
      get api_user_rewards_path(user_id: user.id), headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["data"].size).to eq(2)
      expect(json["data"].map { |p| p["attributes"]["reward_type"] }).to match_array([ "free_coffee", "free_movie_tickets" ])
    end

    it "returns 404 if user not found" do
      get api_user_rewards_path(user_id: -1), headers: headers

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)
      expect(json["error"]).to eq("User not found")
    end
  end
end
