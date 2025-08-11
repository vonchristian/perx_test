require 'rails_helper'

RSpec.describe ApiClient, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'callbacks' do
    it '#generate_api_key' do
      api_client = FactoryBot.create(:api_client, name: 'Mobile API')

      expect(api_client.api_key).to_not be_nil
    end
  end
end
