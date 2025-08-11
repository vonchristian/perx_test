require 'rails_helper'

RSpec.describe PointLedger, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :purchase }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :reason }
    it { is_expected.to validate_presence_of :points }
    it { is_expected.to validate_numericality_of(:points).only_integer }
  end
end
