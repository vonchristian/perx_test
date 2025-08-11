# spec/requests/api/purchases_spec.rb
require 'rails_helper'

RSpec.describe "API::Purchases", type: :request do
  let(:api_client) { FactoryBot.create(:api_client) }
  let(:user) { FactoryBot.create(:user) }
  let(:headers) { { 'Authorization' => "Bearer #{api_client.api_key}", 'Content-Type' => 'application/json', 'Accept' => 'application/json' } }
  let(:valid_params) do
    {
      purchase: {
        user_id: user.id,
        amount_cents: 15_000,
        country: "US"
      }
    }.to_json
  end

  describe "POST /api/purchases" do
    context "with valid params and authentication" do
      it "creates a purchase and returns serialized JSON with 201" do
        post "/api/purchases", params: valid_params, headers: headers

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)

        expect(json.dig('data', 'id')).to be_present
        expect(json.dig('data', 'attributes', 'amount_cents')).to eq(15_000)
        expect(json.dig('data', 'attributes', 'country')).to eq("US")
        expect(json.dig('data', 'attributes', 'amount')).to be_present
      end
    end

    context "without authentication" do
      it "returns 401 Unauthorized" do
        post "/api/purchases", params: valid_params, headers: { 'Content-Type' => 'application/json' }

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with invalid user_id" do
      it "returns 404 not found" do
        invalid_params = {
          purchase: {
            user_id: 0,
            amount_cents: 15_000,
            country: "US"
          }
        }.to_json

        post "/api/purchases", params: invalid_params, headers: headers

        expect(response).to have_http_status(:not_found)
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("User not found")
      end
    end
  end
end
