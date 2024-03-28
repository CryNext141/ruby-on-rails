class MoviesController < ApplicationController
  before_action :set_film, only: [:edit, :update, :destroy]

  # GET /films/new
  def new
    @movie = Movie.new
  end

  # POST /films
  def create
    @movie = current_user.movie.build(movie_params)

    if @movie.save
      redirect_to @movie, notice: 'Film was successfully created.'
    else
      render :new
    end
  end

  # GET /films/:id/edit
  def edit
  end

  # PATCH/PUT /films/:id
  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Film was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /films/:id
  def destroy
    @movie.destroy
    redirect_to movie_url, notice: 'Film was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_film
    @movie = Movie.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def film_params
    params.require(:movie).permit(:title, :description)
  end
end
