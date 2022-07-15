class TracksController < ApplicationController
  before_action :set_track, only: %i[ show update destroy ]

  # GET /tracks
  def index
    @tracks = Track.all

    render json: @tracks
  end

  # GET /tracks/1
  def show
    render json: @track
  end

  # POST /tracks
  def create
    @track = Track.new(track_params)

    if @track.save
      render json: @track, status: :created, location: @track
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tracks/1
  def update
    if @track.update(track_params)
      render json: @track
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tracks/1
  def destroy
    @track.destroy
  end

  # FIND BY ARTIST /tracks/artist/1
  def tracks_artist
    @tracks = Track.where(artist_id: params[:artist_id])
    render json: @tracks
  end

  # FIND BY ALBUM /tracks/album/1
  def tracks_album
    @tracks = Track.where(album_id: params[:album_id])
    render json: @tracks
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def track_params
      params.require(:track).permit(:album_id, :disc_number, :duration_ms, :name, :preview_url, :track_number)
    end
end
