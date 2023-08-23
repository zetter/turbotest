class ActorsController < ApplicationController
  before_action :set_actor, only: %i[ show edit update destroy ]

  # GET /actors or /actors.json
  def index
    @actors = Actor.all
  end

  # GET /actors/1 or /actors/1.json
  def show
  end

  # GET /actors/new
  def new
    @actor = Actor.new
  end

  # GET /actors/1/edit
  def edit
  end

  # POST /actors or /actors.json
  def create
    @actor = Actor.new(actor_params)

    if @actor.save
      redirect_to movie_url(@actor.movie), notice: "Actor was successfully created."
    else
      ## one option is to redirect to a actor specific page with the error.
      ## This means having two forms (movies#show and actors#new)
      render :new, status: :unprocessable_entity 
      
      ## another option is to redirect to the movie page with the error
      ## This is the simplest option and I would recommend this unless there is lots of validation on the form
      redirect_to movie_url(@actor.movie), notice: "Actor could not be created."

      ## Another option is to render the movie page, setting up the @movie and the @actor.
      ## If doing this, it would better to move this to movies controller as a #create_actor action 
      ## so all the setup needed for the show tempalte can be done.
      @movie = actor.movie
      render "movies/show", status: :unprocessable_entity
    end
  end

  # PATCH/PUT /actors/1 or /actors/1.json
  def update
    if @actor.update(actor_params)
      redirect_to actor_url(@actor), notice: "Actor was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /actors/1 or /actors/1.json
  def destroy
    @actor.destroy

    redirect_to actors_url, notice: "Actor was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actor
      @actor = Actor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def actor_params
      params.require(:actor).permit(:name, :movie_id)
    end
end
