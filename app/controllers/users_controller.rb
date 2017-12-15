class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.first_name = params['first_name']
    @user.last_name = params['last_name']
    @user.email = params['email']
    @user.city = params['city']
    @user.state = params['state']
    @user.save
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    flash[:errors] = @user.errors
    redirect_to :back
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to '/events'
    else
      flash[:errors] = @user.errors
      redirect_to :back
    end
  end

  private
  def user_params
    params.require(:new).permit(:first_name, :last_name, :email, :city, :state, :password, :password_confirmation)
  end
  def update_params
    params.require(:update).permit(:first_name, :last_name, :email, :city, :state)
  end
end
