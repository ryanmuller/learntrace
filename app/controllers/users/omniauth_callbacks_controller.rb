class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env["omniauth.auth"]
    @user = User.find_for_facebook_oauth(auth, current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    elsif current_user
      current_user.update_attributes({ :provider => auth.provider, :uid => auth.uid })
      redirect_to root_url
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
