class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites
  has_many :book_comments

  #自分がフォローしている人のリレーション、Relationshipモデルの中のエイリアスから外部キーを参照して持ってくる
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 自身がフォローしている人(A)とその人をフォローしている人(B)を結びつける
  has_many :following, through: :active_relationships, source: :followed
  # 自身をフォローしている人のリレーション
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自身をフォローしている人(C)とその人がフォローしている人（B）を結びつける
  has_many :followers, through: :passive_relationships, source: :follower

  # フォローするメソッドの定義
  def follow(other_user)
    # フォローしている人はother_userに含まれており、これは自身ではない
    following << other_user unless self == other_user
  end

  # フォロー解除のメソッドの定義
  def unfollow(other_user)
    following.delete(other_user)
  end

  # 指定したuserがフォローしている人に含まれているかどうかの確認
  def following?(other_user)
    following.include?(other_user)
  end


  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
