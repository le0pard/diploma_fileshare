class Notifier < ActionMailer::Base
  default :from => "from@example.com"
  layout 'email'
  
  def password_reset_instructions(user)
    @user = user
    @password_reset_url = edit_password_resets_url(:perishable_token => user.perishable_token)
    mail(:subject => I18n.t("emails.deliver_password_reset_instructions.subject"),
      :to => user.email) do |format| 
        format.html
        format.text
    end
  end
end
