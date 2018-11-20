class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]
  before_action :set_lab
  before_action :authenticate_user!, except: [:index, :show]

  # GET /works
  # GET /works.json
  def index
    @works = Work.all
  end
  # def index
  #   @works = Work.where(lab_id: params[:lab_id])
  # end

  # GET /works/1
  # GET /works/1.json
  def show
  end

  # GET /works/new
  def new
    @work = Work.new
  end

  # GET /works/1/edit
  def edit
  end

  # POST /works
  # POST /works.json
  def create
    @work = Work.new(work_params)

    respond_to do |format|
      if @work.save
        format.html { render :show, notice: 'Works was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update
    respond_to do |format|
      if @work.update(work_params)
        format.html { render :show, notice: 'Work was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    @work.destroy
    respond_to do |format|
      format.html { redirect_to lab_path(@lab)}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end

    # lab を取得
    def set_lab
      @lab = Lab.find(params[:lab_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.require(:work).permit(:name, :description, :lab_id, :image)
    end
end
