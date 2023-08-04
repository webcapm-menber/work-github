class GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルの新規登録が完了しました。"
      redirect_to genres_path
    else
      flash[:notice] = "項目を再度確認してください"
      @genres = Genre.all
      render :index
    end

  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    if @genre.save
      flash[:notice] = "変更が完了しました。"
      redirect_to genres_path
    else
      flash[:notice] = "変更に失敗しました。"
      render :edit
    end
  end


  private

  def genre_params
     params.require(:genre).permit(:name)
  end


end
