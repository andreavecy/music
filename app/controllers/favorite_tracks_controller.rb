class FavoriteTracksController < ApplicationController
  before_action :set_favorite_track, only: %i[ show update destroy ]

  # GET /favorite_tracks
  def index
    @favorite_tracks = FavoriteTrack.all

    render json: @favorite_tracks
  end

  # GET /favorite_tracks/1
  def show
    render json: @favorite_track
  end

  # POST /favorite_tracks
  def create
    @favorite_track = FavoriteTrack.new(favorite_track_params)

    if @favorite_track.save
      render json: @favorite_track, status: :created, location: @favorite_track
    else
      render json: @favorite_track.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /favorite_tracks/1
  def update
    if @favorite_track.update(favorite_track_params)
      render json: @favorite_track
    else
      render json: @favorite_track.errors, status: :unprocessable_entity
    end
  end

  # DELETE /favorite_tracks/1
  def destroy
    @favorite_track.destroy
  end

  def user_favorites
    @user = User.find(params[:user_id])
    @tracks = @user.tracks
    render json: @tracks
  end

  def track_user_favorites
    @track = Track.find(params[:track_id])
    @users = @track.users
    render json: @users
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite_track
      @favorite_track = FavoriteTrack.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favorite_track_params
      params.require(:favorite_track).permit(:user_id, :track_id)
    end
end
