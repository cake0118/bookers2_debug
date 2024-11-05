class SearchesController < ApplicationController
  def search
    # どのモデルから検索するか？
    @model = params[:model]
    # 検索方法の指定(モデルの方で作ったメソッド名)
    @search_method = params[:search_method]
    # 入力された文字列
    @query = params[:query]
    # indexアクションが適応されているページに必要な情報(検索時に入力、選択されたもの)を持って飛ぶ
    redirect_to action: :index, model: @model, search_method: @search_method, query: @query

  end

  def index
    # searchから渡されたものを挿入する
    @model = params[:model]
    @search_method = params[:search_method]
    @query = params[:query]
    # viewファイルで表示するものの選択
    @results = if @model == 'User'
                # Userモデルから一致するものを持ってくる
                User.search(@search_method, @query)
               elsif @model == 'Book'
                # Bookモデルから一致するものを持ってくる
                Book.search(@search_method, @query)
               else
                # 選択されたモデルが空なら空を返す
                []
               end
  end
end
