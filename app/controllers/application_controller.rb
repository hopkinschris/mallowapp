require 'action_pack'

class ApplicationController < ActionController::Base
  include ActionView::Helpers::OutputSafetyHelper
  protect_from_forgery

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Mongoid::Errors::DocumentNotFound
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end
    
    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        flash[:error]= raw(t 'alert.user.denied')
        redirect_to root_url
      end
    end

    def authenticate_user!
      if !current_user
        flash[:error]= t 'alert.user.auth'
        redirect_to root_url
      end
    end
    
end
