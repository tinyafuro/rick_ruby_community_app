class Community < ApplicationRecord

  #User／Communityの関連付け（１対１）
  belongs_to :user
  has_many :community_join, dependent: :destroy
  has_many :followers, through: :community_joins, source: :users
  
  #デフォルトの順序を指定
  default_scope -> { order(created_at: :desc) }
  
  #画像アップローダー
  mount_uploader :picture, PictureUploader
  validate :picture_size
  
  #バリデーション
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 1000 }


  private
  
    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
