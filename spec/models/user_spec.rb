require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :purchases }
    it { is_expected.to have_many :point_ledgers }
    it { is_expected.to have_many :rewards }
  end
end
