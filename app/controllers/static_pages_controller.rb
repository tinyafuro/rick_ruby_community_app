class StaticPagesController < ApplicationController

  def home
    # すべてのコミュニティ情報取得
    @communities = Community.paginate(page: params[:page], per_page: 10)
    # 現在のURLを記憶
    before_location root_path

    # if logged_in?
      # @community  = current_user.community.build
      # @feed_items = current_user.feed.paginate(page: params[:page])
    # end
  end

  def help
  end

  def about
  end

  def contact
  end
  
end
