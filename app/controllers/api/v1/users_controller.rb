# coding: utf-8
class Api::V1::UsersController < ApiController 
#  skip_before_filter  :verify_authenticity_token

  # POST /v1/users/sign_up
  # account登録とaccess_tokenを生成
  def sign_up
    @user = User.new(sign_up_params)

    if @user.save
      render
    else
      error422 @user.full_messages
    end
  end

  def sign_in
    @user = User.find_by!(email: params[:email])
    if @user && @user.authenticate(params[:password])
      @apikey = Apikey.find_or_create_by(user_id: @user.id)
      render
    else
      error401 @user.full_messages
    end
  end

  private
    
    def sign_up_params
      params.permit(:email, :password, :password_confirmation)
    end

end
