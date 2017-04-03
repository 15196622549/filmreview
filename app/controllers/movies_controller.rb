class MoviesController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy, :join, :quit]

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    if @movie.save
      current_user.join!(@movie)
      redirect_to movies_path
    else
        render :new
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews
  end

  def edit
    @movie = Movie.find(params[:id])
    if current_user != @movie.user
      redirect_to root_path, alert: "you have no permission"
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if current_user != @movie.user
      redirect_to root_path, alert: "you have no permission"
    end
    if @movie.update(movie_params)
       redirect_to movies_path
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    if current_user != @movie.user
      redirect_to root_path, alert: "you have no permission"
    end
    @movie.destroy
    redirect_to movies_path
  end

  def join
    @movie = Movie.find(params[:id])

     if !current_user.is_fan_of?(@movie)
       current_user.join!(@movie)
       flash[:notice] = "favorited"
     else
       flash[:warning] = "have been favorited"
     end
     redirect_to movie_path(@movie)
   end

   def quit
     @movie = Movie.find(params[:id])

     if current_user.is_fan_of?(@movie)
       current_user.quit!(@movie)
     else
     end
    redirect_to movie_path(@movie)
  end




  private

    def find_movie_and_check_permission
      @movie = Movie.find(params[:id])
      if current_user != @movie.user
        redirect_to root_path, alert: "you have no permission"
      end
    end
    def  movie_params
      params.require(:movie).permit(:title, :description)
    end
 end
