class SessionsController < ApplicationController
	def new
	end

	def create
		#debugger        use debugger to check the params
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:success] = "You have successfully logged in !"
			redirect_to user_path(user)
		else
			flash.now[:danger] = "Wrong login information match" #let the flash info show in the current page
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "You have successfully logged out !"
		redirect_to root_path
	end
end
