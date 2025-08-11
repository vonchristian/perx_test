class ApiClient < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = SecureRandom.hex(32)
  end
end
