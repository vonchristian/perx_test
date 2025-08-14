# spec/requests/api/users/rewards_spec.rb
require "rails_helper"

RSpec.describe "API::Users::Rewards", type: :request do
  let(:api_client) { FactoryBot.create(:api_client) }
  let(:headers) do
    {
      'Authorization' => "Bearer #{api_client.api_key}",
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:user) { FactoryBot.create(:user, birth_date: Date.current) }


  describe "POST /api/users/:user_id/rewards" do
    context "when user exists and rewards are created successfully" do
      it "returns created rewards JSON with status 201" do
        post api_user_rewards_path(user_id: user.id), headers: headers
        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)
        expected_json = UsersSerializer.new(user.reload, include: [ :rewards ]).serializable_hash.as_json

        expect(json).to eq(expected_json)
      end
    end

    context "when user does not exist" do
      it "returns 404 not found" do
        post api_user_rewards_path(user_id: -1), headers: headers

        expect(response).to have_http_status(:not_found)
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("User not found")
      end
    end

    context "when service is invalid" do
      before do
        allow(Rewards::Award).to receive(:run).with(user: user).and_return(
          instance_double(
            ActiveInteraction::Base,
            valid?: false,
            errors: double(full_messages: [ "Some error occurred" ])
          )
        )
      end

      it "returns 422 unprocessable entity with errors" do
        post api_user_rewards_path(user_id: user.id), headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["errors"]).to include("Some error occurred")
      end
    end
  end
end
