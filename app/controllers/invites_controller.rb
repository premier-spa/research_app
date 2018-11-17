class InvitesController < ApplicationController
  before_action :set_lab

  LAB_INVITE_TOKEN_TYPE = 0

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
  end

  # 招待メールクリック後に来るアクション
  # ユーザ登録がある場合研究室招待完了画面にそのまま遷移
  # 登録のない人はユーザ登録にリダイレクト
  def confirm
    one_time_token = OneTimeToken.find_by(token: params[:token])
    mail_address = one_time_token.mail_address
    user = User.find_by(email: mail_address)
    if user.nil?
      # ユーザ新規ページへ
      redirect_to controller: 'devise/registrations', action: 'new'
    else
      lab_user = LabUser.new({user_id: user.id, lab_id: @lab.id})
      if lab_user.save
        one_time_token.destroy
        # ログインユーザを変える
        redirect_to action: 'complete'
      else
        # do something
      end
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
