class User < ActiveRecord::Base
  has_one :apikey

  after_save :create_api_key

  has_secure_password
  validates :email, uniqueness: true
  validates :email, :email => true

  def self.find_user_by_token(token, includes_inside=nil, joins_inside=nil)
    apikey = Apikey.find_by!(access_token: token)
    User.joins(joins_inside).includes(includes_inside).find(apikey.user_id)
  end

  private
    def create_apikey
      unless Apikey.exists?(user_id: id)
        @apikey = Apikey.create(user_id: id)
      end
    end

end
