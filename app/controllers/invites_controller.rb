class InvitesController < ApplicationController
  before_action :set_lab

  def new
  end

  def create
    mail_address = params[:mail_address]
    LabInviteMailer.send_lab_invitation(mail_address, @lab).deliver
  end

  def confirm
  end

  def complete
  end

  private
  def set_lab
    @lab = Lab.find(params[:id])
  end
end
