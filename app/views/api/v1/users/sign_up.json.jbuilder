json.extract! @user, :id, :email
json.access_token @user.apikey.access_token
