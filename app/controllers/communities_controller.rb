class CommunitiesController < ApplicationController

  before_action :logged_in_user, only: [:create, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @communities = Community.paginate(page: params[:page])
    #現在のURLを記憶
    before_location communities_path
  end

  def show
    @community = Community.find(params[:id])
  end

  def edit
    @community = Community.find(params[:id])
  end

  def create
    # @community = current_user.community.build(community_params)
    if @community.save
      flash[:success] = "Community created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def update    
    # @community = Community.find(params[:id])
    if @community.update_attributes(community_params)
      flash[:success] = "Community updated"
      redirect_to @community
    else
      render 'edit'
    end
  end
  
  def destroy
    @community.destroy
    flash[:success] = "Community deleted"
    # redirect_to request.referrer || root_url
    redirect_to redirect_before_url
  end
  
  private

    def community_params
      params.require(:community).permit(:title, :body, :picture)
    end

    def correct_user
      @community = current_user.community.find_by(id: params[:id])
      redirect_to root_url if @community.nil?
    end

end
