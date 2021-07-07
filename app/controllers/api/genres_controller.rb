class Api::GenresController < ApplicationController
  def index
    @genres = Genre.all
    render "index.json.jb"
  end

  def show
    @genre = Genre.find_by(id: params[:id])

    render "show.json.jb"
  end
end
