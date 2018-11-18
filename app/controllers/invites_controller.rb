class InvitesController < ApplicationController
  before_action :set_lab

  # 研究室招待に使われる one_time_token の種類
  LAB_INVITE_TOKEN_TYPE = 0
  # 招待ユーザでログインしていない場合に表示するエラーメッセージ
  ERROR_MESSAGE_INVALID_USER = '招待ユーザでログインしてください。'
  # 研究室招待が完了していない場合に表示するエラーメッセージ
  ERROR_MESSAGE_MISS_INVITE_LAB = '研究室招待処理が完了しませんでした。'

  def new
  end

  def create
    mail_address = params[:mail_address]
    token = Digest::SHA1.hexdigest([Time.now, rand].join)
    OneTimeToken.create({
      mail_address: mail_address,
      type: LAB_INVITE_TOKEN_TYPE,
      token: token
    })
    LabInviteMailer.send_lab_invitation(mail_address, token, @lab).deliver
    redirect_to invites_send_lab_url(@lab)
  end

  # 招待メールクリック後に来るアクション
  # ユーザ登録がある場合研究室招待完了画面にそのまま遷移
  # 登録のない人はユーザ登録にリダイレクト
  def confirm
    one_time_token = OneTimeToken.find_by(token: params[:token])
    user = User.find_by(email: one_time_token.mail_address)

    # ユーザ登録がない場合
    return redirect_to new_user_registration_url(nil, {invited_lab_id: @lab.id, email: one_time_token.mail_address}) if user.nil?

    # ログインしているかチェック
    authenticate_user!

    # ログインユーザが違う場合
    return redirect_to action: 'new', alert: ERROR_MESSAGE_INVALID_USER if current_user.id != user.id

    lab_user = LabUser.new({user_id: user.id, lab_id: @lab.id})
    if lab_user.save
      one_time_token.destroy
      redirect_to action: 'complete'
    else
      redirect_to action: 'new', alert: ERROR_MESSAGE_MISS_INVITE_LAB
      return
    end
  end

  # 完了画面
  def complete
  end

  private
  def set_lab
    @lab = Lab.find(params[:id])
  end
end
