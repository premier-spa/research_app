class PeopleController < ApplicationController
  before_action :set_lab, only: [:index, :show]
  # 研究室メンバー一覧
  def index
    @lab_professors = @lab.professors
    @lab_students = @lab.students
  end

  # 研究室メンバー詳細
  def show
    @user = User.find(params[:id])
    # 研究室所属メンバー以外のユーザを指定された場合研究室トップに遷移
    if !@lab.is_lab_user?(@user)
      redirect_to lab_url(@lab)
    end
  end

  private
  def set_lab
    @lab = Lab.find(params[:lab_id])
  end
end
