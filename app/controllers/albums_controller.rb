class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :set_lab
  before_action :authenticate_user!, except: [:index, :show]

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  # GET /album/new
  def new
    @album = Album.new
  end

  # GET /album/1/edit
  def edit
  end

  # POST /album
  # POST /album.json
  def create
    @album = Album.new(album_params)
    if images = params[:album][:images]
      @album.images.attach(images)
    end
    respond_to do |format|
      if @album.save
        format.html { render :show, notice: 'album was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /album/1
  # PATCH/PUT /album/1.json
  def update
    # 選択された画像を削除
    if !params[:album][:image_ids].nil?
      delete_images(params[:album][:image_ids])
    end
    # 追加登録
    if images = params[:album][:images]
      @album.images.attach(images)
    end
    respond_to do |format|
      if @album.update(album_params)
        format.html { render :show, notice: 'album was successfully created.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /album/1
  # DELETE /album/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html {redirect_to lab_path(@lab)}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # lab を取得
    def set_lab
      @lab = Lab.find(params[:lab_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:name, :lab_id, :images)
    end

    def delete_images(image_ids)
      image_ids.each do |image_id|
        image = @album.images.find(image_id)
        image.purge
      end
    end
end
