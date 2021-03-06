class LabInviteMailer < ApplicationMailer
    default from: "goodlab@example.com"

    # lab への招待メールを送る
    def send_lab_invitation(mail_address, token, invited_lab)
        @token = token
        @invited_lab = invited_lab
        mail(
            subject: "研究室メンバーへの招待",
            to: mail_address
        ) do |format|
            format.text
        end
    end
end
