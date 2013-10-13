class UsersController < ApplicationController
    
    before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
    before_filter :correct_user,   only: [:edit, :update]
    before_filter :admin_user,     only: :destroy
    
  def show
      @user = User.find(params[:id])
  end
    
  def index
      @users = User.paginate(page: params[:page], per_page: 1)
  end
    
  def new
      @user = User.new
      subscription = @user.subscriptions.build
      @plans = Plan.all
  end
    
  def create
      @user = User.new(params[:user])
      if @user.save
         sign_in @user
         flash[:success] = "Welcome to Account Hero!"
          redirect_to root_path
      else
         redirect_to new_user_path
      end
  end
    
  def edit
      @plans = Plan.all
      @subscription = Subscription.new(params[:subscription])
      @subscription.email = current_user.email
      @subscription.user_id = current_user.id
      @user = current_user
      if @user.subscriptions.empty?
      subscription = @user.subscriptions.build
      end
  end
    
  def update
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
          
          sign_in @user
                if !current_user.next_step.blank?
                    redirect_to edit_user_path(@user, :step => current_user.next_step)
                    else
                    redirect_to root_path
            end
          else
          render 'edit'
      end
  end
    
  def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
  end
    
    private
    
    def signed_in_user
        unless signed_in?
            store_location
            redirect_to signin_url, notice: "Please sign in."
        end
    end

    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
        redirect_to(root_path) unless current_user.admin?
    end
end
