class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy, :about, :contact]
  before_action :set_news, only: [:show]
  before_action :set_albums, only: [:show]
  before_action :set_works, only: [:show]

  # lab のメンバーではない人がアクセスしたときに弾く
  before_action :authenticate_lab_user?, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new]

  # 検索 1 ページあたりの研究室数
  PER_PAGE_LABS_NUM = 5

  # ホームで表示するニュース数
  NEWS_IN_HOME_NUM = 5

  # ホームで表示する研究内容数
  WORKS_IN_HOME_NUM = 6

  # GET /labs
  # GET /labs.json
  def index
    # 検索用語を取り出す
    @query_string = params[:search]
    # Lab の検索結果(ES より返ってくる object の形式)
    lab_result = Lab.search(@query_string)
    # lab_id を取り出す
    lab_ids = lab_result.map {|obj| obj.id }
    # lab_id をもとに Lab モデルのオブジェクトを設定
    @labs = Lab.page(params[:page]).per(PER_PAGE_LABS_NUM).where(id: lab_ids)
  end

  # GET /labs/1
  # GET /labs/1.json
  def show
  end

  # GET /labs/new
  def new
    @lab = Lab.new
  end

  # GET /labs/1/edit
  def edit
  end

  # POST /labs
  # POST /labs.json
  def create
    @lab = current_user.labs.build(lab_params)
    if image = params[:lab][:image]
      @lab.image.attach(image)
    end
    respond_to do |format|
      if current_user.save
          format.html { redirect_to @lab, notice: 'Lab was successfully created.' }
          format.json { render :show, status: :created, location: @lab }
      else
        format.html { render :new }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /labs/1
  # PATCH/PUT /labs/1.json
  def update
    respond_to do |format|
      if @lab.update(lab_params)
        format.html { redirect_to @lab, notice: 'Lab was successfully updated.' }
        format.json { render :show, status: :ok, location: @lab }
      else
        format.html { render :edit }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labs/1
  # DELETE /labs/1.json
  def destroy
    @lab.destroy
    respond_to do |format|
      format.html { redirect_to labs_url, notice: 'Lab was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /labs/1/about
  def about
    @lab_professor = @lab.professors.first
  end

  # GET /labs/1/contact
  def contact
    # Google Map のアクセスキーを取得
    @map_script_path = "https://maps.googleapis.com/maps/api/js?key=#{ENV['GOOGLE_API_KEY']}&callback=initMap"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lab
      @lab = Lab.find(params[:id])
    end

    # lab に紐づくニュース一覧を取得
    def set_news
      @news = News.where(lab_id: params[:id]).limit(NEWS_IN_HOME_NUM)
    end

    # lab に紐づくアルバム一覧を取得
    def set_albums
      @albums = Album.where(lab_id: params[:id])
    end

    # lab に紐づく研究内容一覧を取得
    def set_works
      @works = Work.where(lab_id: params[:id]).limit(WORKS_IN_HOME_NUM)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lab_params
      params.require(:lab).permit(:name, :majar, :about_us, :purpose, :message, :facility, :address, :tel, :fax, :email, :access, :lon, :lat)
    end

    def authenticate_lab_user?
      authenticate_user!
      unless @lab.is_lab_user?(current_user)
        redirect_to new_user_session_url
      end
    end
end
