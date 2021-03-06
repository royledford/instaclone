class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # Only logged in users can edit/update a profile page
  # TODO: Remove the :index for production
  before_action :logged_in_user, only: [:index, :edit, :update]
  # Users can only edit their own profile page
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    # Email activation code, not working
    # redirect_to root_url and Return unless @user.activated?
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    # respond_to do |format|
      if @user.save
        @user.send_activation_email
        # Email activation of account code.
        # not currently working
        # flash[:info] = "We sent you an email, please follow the link to complete
        #                 your account setup."
        # redirect_to login_path
        log_in @user
        redirect_to @user
        flash[:notice] =  'Welcome to Instaclone.'
        # format.html { redirect_to @user, notice: 'Welcome to Instaclone.' }
      else
        render :new
      end
    # end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Your profile was updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :password, :password_confirmation, :email)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:warn] = "Please log in before making changes."
        redirect_to login_path
      end
    end

    # Confirm the correct user is accessing various methods
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
