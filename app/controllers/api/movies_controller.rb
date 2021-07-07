class Api::MoviesController < ApplicationController
  def index
    @movies = Movie.order(:id => :asc)
    render "index.json.jb"
  end

  def show
    @movie = Movie.find_by(id: params[:id])
    # @movie = Movie.find(Movie.pluck(:id).sample)

    render "show.json.jb"
  end

  def random
    # Active Record Search:

    # @m = Movie.where(year: 2021, rating: "R", language: "English", runtime_minutes: 242, media_type: "movie")
    # @genre = Genre.find_by(name: "Action")
    # genre_movies = @genre.movies
    # @network = Network.find_by(name: "HBO Max")
    # network_movies = @network.movies
    # @movie = @m & genre_movies & network_movies
    # @movie.sample
    # @final_movie = @movie.sample

    # @m = Movie.where(year: params[:year], rating: params[:rating], language: params[:language], runtime_minutes: params[:runtime_minutes], media_type: params[:media_type])
    # @genre = Genre.find_by(name: params[:genre])
    # genre_movies = @genre.movies
    # @network = Network.find_by(name: params[:network])
    # network_movies = @network.movies
    # @movie = @m & genre_movies & network_movies
    # @final_movie = @movie.sample
    # MVP - ALL PARAMS
    # @m = Movie.where(year: params[:year], rating: params[:rating], language: params[:language], runtime_minutes: params[:runtime_minutes], media_type: params[:media_type])
    # @genre = Genre.find_by(name: params[:genre])
    # @network = Network.find_by(name: params[:network])
    # @movie = @m and @genre.movies and @network.movies
    # @final_movie = @movie.sample

    if params[:genre]
      @final_movie = Movie.joins(:genres).where(genres: { name: params[:genre] }).sample
      # Works if only network is selected
    elsif params[:network]
      @final_movie = Movie.joins(:networks).where(networks: { name: params[:network] }).sample
      # elsif params[:network] && params[:genre]
      #   @final_movie = Movie.joins(:genres, :networks).where(genres: { name: params[:genre] }, networks: { name: params[:network] }).sample
      # Works if one, some, all or none are selected unless genre/network are selcted
    else
      final_params = { year: params[:year], rating: params[:rating], language: params[:language], runtime_minutes: params[:runtime_minutes], media_type: params[:media_type] }
      @final_movie = Movie.where(final_params.compact).sample
    end

    render "random.json.jb"
  end

  def test
    # # random movie
    # movies = Movie.all
    # @movie = Movie.find(Movie.pluck(:id).sample)
    # # random movie based on year
    # @movies_year = Movie.where(year: params[:year]).sample
    # # # # random movie based on rating
    # @movies_rating = Movie.where(rating: params[:rating]).sample
    # # # # random movie based on rating and year
    # # @year_rating = @movies_year & @movies_rating
    # # # # random movie based on media type
    # @movies_type = Movie.where(media_type: params[:media_type]).sample
    # # # # random movie based on language
    # @movies_language = Movie.where(language: params[:language]).sample
    # # # # random movie based on runtime
    # @movies_runtime = Movie.where("runtime_minutes <= :runtime_minutes AND runtime_minutes >= :runtime_minutes", runtime_minutes: params[:runtime_minutes])
    # # random movie based on network
    # @network = Network.find_by(name: params[:network])
    # @network_movies = @network.movies
    # # @movie_by_network = @movie_network.movies

    # # # random movie based on genre
    # @genre = Genre.find_by(name: params[:genre])
    # @genre_movies = @genre.movies

    # ALL WORKING. ONLY WORKING TOP DOWN/INDIVIDUAL PARAMS. THE CODE IN RANDOM ACTION FOR ALL PARAMS, DOES NOT WORK WITH THIS LOGIC CURRENTLY. NEED TO ADD MULTIPLE PARAMS FUNCTIONALITY AND GET WORKING WITH ALL PARAMS TO THEN COMBINE AND ADD TO THE FRONTEND

    # **THIS WORKS FOR THE MOVIE PARAMS, ALL MULTIPLE, OR NONE. DOESNT WORK WITH GENRE OR NETWORK**

    # final_params = { year: params[:year], rating: params[:rating], language: params[:language], runtime_minutes: params[:runtime_minutes], media_type: params[:media_type] }
    # @final_movie = Movie.where(final_params.compact).sample

    # Works if only genre is selected
    # if params[:genre]
    #   @final_movie = Movie.joins(:genres).where(genres: { name: params[:genre] }).sample
    #   # Works if only network is selected
    # elsif params[:network]
    #   @final_movie = Movie.joins(:networks).where(networks: { name: params[:network] }).sample
    #   # Works if one, some, all or none are selected unless genre/network are selcted
    # else
    #   final_params = { year: params[:year], rating: params[:rating], language: params[:language], runtime_minutes: params[:runtime_minutes], media_type: params[:media_type] }
    #   @final_movie = Movie.where(final_params.compact).sample
    # end

    # *WORK IN PROGRESS TO TIE ALL TOGETHER*

    # binding.pry
    # if params[:genre]
    #   @genre_movies = Movie.joins(:genres).where(genres: { name: params[:genre] }).sample
    #   # @final_movie = @genre_movies
    # end

    # if params[:network]
    #   @network_movies = Movie.joins(:networks).where(networks: { name: params[:network] }).sample
    #   # @final_movie = @network_movies
    # end

    # if final_params = { year: params[:year], rating: params[:rating], language: params[:language], runtime_minutes: params[:runtime_minutes], media_type: params[:media_type] }
    #   @filtered_movies = Movie.where(final_params.compact).sample
    # end

    # @final_movie = @filtered_movies & @genre_movies & @network_movies
    # binding.pry
    final_params = { year: params[:year], rating: params[:rating], language: params[:language], runtime_minutes: params[:runtime_minutes], media_type: params[:media_type], networks: { name: params[:network] }, genres: { name: params[:genre] } }

    @final_movie = Movie.joins(:genres, :networks).where(final_params.compact).sample

    # @final_movie = Movie.joins(:genres, :networks).where(genres: { name: params[:genre] }, networks: { name: params[:network] }).sample
    # @final_movie = Movie.joins(:networks).where(networks: { name: params[:network] }).sample
    # @final_movie = Movie.joins(:genres).where(genres: { name: params[:genre] }).sample

    # if params[:year]
    #   final_params[:year] = params[:year]
    #   @final_movie = Movie.where(final_params).sample
    # elsif params[:rating]
    #   final_params[:rating] = params[:rating]
    #   @final_movie = Movie.where(final_params).sample
    # elsif params[:media_type]
    #   final_params[:media_type] = params[:media_type]
    #   @final_movie = Movie.where(final_params).sample
    # elsif params[:language]
    #   final_params[:language] = params[:language]
    #   @final_movie = Movie.where(final_params).sample
    # elsif params[:runtime_minutes]
    #   final_params[:runtime_minutes] = params[:runtime_minutes]
    #   @final_movie = Movie.where(final_params).sample
    # elsif params[:genre]
    #   @genre = Genre.find_by(name: params[:genre])
    #   @final_movie = @genre.movies.sample
    # elsif params[:network]
    #   @network = Network.find_by(name: params[:network])
    #   @final_movie = @network.movies.sample
    # elsif final_params
    #   final_params = { year: params[:year], rating: params[:rating], language: params[:language], runtime_minutes: params[:runtime_minutes], media_type: params[:media_type] }
    #   @final_movie = Movie.where(final_params).sample
    # else
    #   @final_movie = Movie.find(Movie.pluck(:id).sample)
    # end

    # final_params = { year: params[:year], rating: params[:rating], language: params[:language], runtime_minutes: params[:runtime_minutes], media_type: params[:media_type] }

    # @final_movie = Movie.where(final_params).sample

    # @final_movie = @movie = Movie.where("year like ?", "%2017%").sample

    # @final_movie = Movie.filter(params.slice(:year, :rating, :media_type, :language, :runtime_minutes)).sample

    render "test.json.jb"
  end

  # if (@movie = Movie.where(media_type: params[:media_type], rating: params[:rating]))
  #   # @genre = Genre.find_by(name: params[:genre])
  #   # @network = Network.find_by(name: params[:network])
  #   # @movie = @m & @network.movies
  #   # @final_movie = @movie.sample
  # elsif (@movie = Movie.where(year: params[:year], rating: params[:rating]))
  #   @final_movie = @movie.sample
  # end

  # if @m == Movie.where(year: 2021)
  #   @final_movie = @m.sample
  # elsif @m == Movie.where(rating: "R")
  #   @@final_movie = @m.sample
  # end

  # TROUBLESHOOT THESE - THEY DID WORK NOW THEY DONT
  # elsif (@m = Movie.where(year: params[:year], rating: params[:rating])
  #   @final_movie = @m.sample)
  # elsif (@m = Movie.where(year: params[:year], media_type: params[:media_type])
  # @final_movie = @m.sample)

  def title
    @movie = Movie.find_by(title: params[:title])
    render "show.json.jb"
  end
end
