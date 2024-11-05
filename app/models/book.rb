class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :book_comments
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  # ユーザー自身で検索してもらうため
  def self.search(search_method, query)
    case search_method
    # #{query}の場所が検索した文字列がどこにあるかを定義している
    # %はそこに何かしらの文字列が入る可能性を表している
    when '完全一致'
      where(title: query)
    when '前方一致'
      where('title LIKE ?', "#{query}%")
    when '後方一致'
      where('title LIKE ?', "%#{query}")
    when '部分一致'
      where('title LIKE ?', "%#{query}%")
    else
      all
    end
  end


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


end
