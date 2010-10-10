class User < ActiveRecord::Base

  # === List of columns ===
  #   id                  : integer 
  #   email               : string 
  #   crypted_password    : string 
  #   password_salt       : string 
  #   persistence_token   : string 
  #   single_access_token : string 
  #   perishable_token    : string 
  #   login_count         : integer 
  #   failed_login_count  : integer 
  #   last_request_at     : datetime 
  #   current_login_at    : datetime 
  #   last_login_at       : datetime 
  #   current_login_ip    : string 
  #   last_login_ip       : string 
  #   created_at          : datetime 
  #   updated_at          : datetime 
  #   roles               : string 
  # =======================

  
  acts_as_authentic do |c|
    crypto_provider = Authlogic::CryptoProviders::BCrypt
  end
  easy_roles :roles
  
  has_many :uploaded_files
  
  
  
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.password_reset_instructions(self).deliver
  end
  
end
