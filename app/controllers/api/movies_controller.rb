class Api::MoviesController < ApplicationController
  def index
    @movies = Movie.order(:id => :asc)
    render "index.json.jb"
  end

  def show
    @movie = Movie.find_by(id: params[:id])

    render "show.json.jb"
  end

  def random
    # Works if only genre is selected
    if params[:genre]
      @final_movie = Movie.joins(:genres).where(genres: { name: params[:genre] }).sample
      # Works if only network is selected
    elsif params[:network]
      @final_movie = Movie.joins(:networks).where(networks: { name: params[:network] }).sample
      #Works with all, some, or none
    else
      final_params = { year: params[:year], rating: params[:rating], language: params[:language], runtime_minutes: params[:runtime_minutes], media_type: params[:media_type] }
      @final_movie = Movie.where(final_params.compact).sample
    end

    render "random.json.jb"
  end

  def test
    @networks = Network.all

    final_genres = Genre.all.map { |genre|
      genre.name
    }.uniq

    media_types = Movie.all.map { |movie| movie.media_type }.uniq
    languages = Movie.all.map { |movie| movie.language }.uniq
    ratings = Movie.all.map { |movie| movie.rating }.uniq
    years = Movie.order(year: :desc).all.map { |movie| movie.year }.uniq
    lengths = Movie.order(runtime_minutes: :desc).all.map { |movie| movie.runtime_minutes }.uniq
    final_networks = Network.all.map { |network|
      network.name
    }.uniq
    @final_movie = { genres: final_genres, networks: final_networks, media_types: media_types, lengths: lengths, ratings: ratings, years: years, languages: languages }

    render "test.json.jb"
  end

  def title
    @movie = Movie.find_by(title: params[:title])
    render "show.json.jb"
  end
end
