class UsersController < ApplicationController

  # ログイン済みかどうかを事前にチェック
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following]
  # ユーザー編集ページは自分自身以外は入れないようにチェック
  before_action :correct_user,   only: [:edit, :update]
  # 管理者だけがdestroyアクションを発動してユーザーを削除できる
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
    # @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    @communities = @user.community
    @followes = @user.following
    # 現在のURLを記憶
    before_location user_path
    # @communities = @user.community.paginate(page: params[:page], per_page: 5)
    # @followes = @user.following.paginate(page: params[:page], per_page: 5)
    # debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile update"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @communities = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # beforeアクション

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
end
