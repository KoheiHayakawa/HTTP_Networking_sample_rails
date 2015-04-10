require 'securerandom'

class Apikey < ActiveRecord::Base
  belongs_to :user, touch: true
  before_create :generate_access_token

  validates :user_id, presence: true
  validates :access_token, uniqueness: true

  def self.get_user_id(token)
    Apikey.find_by(access_token: token).user_id
  end

  private

    def generate_access_token
      begin
        self.access_token = SecureRandom.uuid.gsub(/\-/,'')
      end while self.class.exists?(access_token: access_token)
    end
end
