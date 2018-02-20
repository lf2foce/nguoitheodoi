class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
    @video = Video.new
    
    respond_to do |format|
      format.html
      format.xlsx {
    response.headers['Content-Disposition'] = 'attachment; filename="all_channels.xlsx"'
    }
    end
    
    @videos.each do |channel|
      refresh(channel)
    end 
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to root_url, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :link, :published_at, :likes, :dislikes, :uid)
    end
    
    def refresh(channel_link)
    	resource = Yt::Channel.new id: channel_link.link.gsub("https://www.youtube.com/channel/","")
    	channel_link.uid = resource.thumbnail_url
    	channel_link.title = resource.title
    	channel_link.likes = resource.videos.count
    	channel_link.dislikes = resource.subscriber_count
    	channel_link.published_at = resource.published_at
  	rescue Yt::Errors::NoItems
  		channel_link.link = 'check again'
    end
end
