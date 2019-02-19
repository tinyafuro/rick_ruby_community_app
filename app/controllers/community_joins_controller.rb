class CommunityJoinsController < ApplicationController

  before_action :logged_in_user

  def create
    @community = Community.find(params[:community_id])
    current_user.follow(@community)
    respond_to do |format|
      format.html { redirect_to @community }
      format.js
    end
  end

  def destroy
    community_id = CommunityJoin.find(params[:id]).community_id
    @community = Community.find(community_id)
    current_user.unfollow(@community)
    respond_to do |format|
      format.html { redirect_to @community }
      format.js
    end
  end

end
