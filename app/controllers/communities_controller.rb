class CommunitiesController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @community = current_user.community.build(community_params)
    if @community.save
      flash[:success] = "Community created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy
    @community.destroy
    flash[:success] = "Community deleted"
    redirect_to request.referrer || root_url
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
