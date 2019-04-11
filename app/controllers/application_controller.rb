class ApplicationController < ActionController::Base
	#check the current user status
	helper_method :current_user, :login?

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
		#use || to avoid continue hitting database
	end

	def login?
        !!current_user     #to get the boolean status but not the object
	end

	def require_user
		if !login?
			flash[:danger] = "You should login to perform the action"
			redirect_to login_path
		end
	end

	def require_admin
	   	  if login? and !current_user.admin?
	   	  	flash[:danger] = "Only administrator can perform the action !"
	   	  	redirect_to root_path
	   	  end
	   end

	
end
