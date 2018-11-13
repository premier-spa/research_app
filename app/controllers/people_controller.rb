class PeopleController < ApplicationController
  before_action :set_lab, only: [:index, :show]
  # 研究室メンバー一覧
  def index
    @lab_professors = @lab.users.where(type: 1)
    @lab_students = @lab.users.where(type: 0)
  end

  # 研究室メンバー詳細
  def show
    @user = User.find(params[:user_id])
    # 研究室所属メンバー以外のユーザを指定された場合研究室トップに遷移
    if !@lab.is_lab_user?(@user)
      redirect_to lab_url(@lab)
    end
  end

  private
  def set_lab
    @lab = Lab.find(params[:id])
  end
end
