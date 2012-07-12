class ApplicationController < ActionController::Base
  protect_from_forgery

  def render404
    render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, :layout => false
    return true
  end

  def after_sign_in_path_for(resource)
    # merge data from Facebook with current account
    if session["devise.facebook_data"] and current_user.uid.nil?
      current_user.provider = "facebook"
      current_user.uid = session["devise.facebook_data"]["uid"]
      current_user.save(:validate => false)
    end
    # countermeasure against session fixation
    session.keys.grep(/^facebook\./).each { |k| session.delete(k) }
    
    super
  end
end
