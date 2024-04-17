class MoviesController < ApplicationController

  # GET /movies
  def index
    @movies = Movie.all
  end

  def search
    if params[:query].present?
      @movies = Movie.search(params[:query])
    else
      @movies = []
    end
  end

  # GET /movies/:id
  def show
    @movie = Movie.find(params[:id])
    # @omdb = OmdbClient.new
    # @omdb_movie = @omdb.search_by_title(@movie.title)
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # POST /movies
  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = 'Movie created'
      redirect_to @movie
    else
      flash[:alert] = @movie.errors.full_messages.join(', ')
      redirect_to new_movie_path
    end
  end

  # GET /movies/:id/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # PUT/PATCH /movies/:id
  def update
    @movie = Movie.find(params[:id])
    @movie.assign_attributes(movie_params)
    if @movie.save
      redirect_to @movie
    else
      flash[:alert] = @movie.errors.full_messages.join(', ')
      redirect_to @movie
    end
  end

  # DELETE /movies/:id
  # DELETE /movies/:id
  def destroy
    @movie = Movie.find(params[:id])
    if @movie.destroy
      flash[:notice] = 'Movie was successfully deleted.'
      redirect_to movies_path
    else
      flash[:alert] = 'Error deleting movie.'
      redirect_to @movie
    end
  end

  def omdb_search
    puts "Search query: #{params[:search_query]}"
    if params[:search_query].present?
      @omdb = OmdbClient.new
      res = @omdb.search(params[:search_query])
      puts "Search result: #{res}"
      @search_result = res['Search']
      unless @search_result
        flash[:alert] = "No movies found or there was an error in the search."
      end
    end

    puts "Search result for view: #{@search_result}"
  end

  def omdb_import
    @omdb = OmdbClient.new

    @omdb_movie = @omdb.find_by_id(params[:omdb_id])

    @movie = Movie.new(
      title: @omdb_movie['Title'],
      cover_image_url: @omdb_movie['Poster'],
      year_of_creation: @omdb_movie['Year'],
      description: @omdb_movie['Plot'],
      duration: @omdb_movie['Runtime'],
      director: @omdb_movie['Director'],
      genres: @omdb_movie['Genre'].split(', ')
    )
    if @movie.save
      redirect_to @movie
    else
      flash[:alert] = @movie.errors.full_messages.join(', ')
      redirect_to omdb_search_movies_path
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :description, :duration, :director, :year_of_creation, genres: [])
  end
end