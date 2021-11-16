class User < ActiveRecord::Base
  has_secure_password  

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: {minimum: 6}

  def self.authenticate_with_credentials(email, password)
    existing_email = email.downcase.strip #strip method removes whitespaces
    
    @user = User.find_by_email(existing_email)
    if @user && @user.authenticate(password) #authenticate is an instance method by has_secure_password gem
      @user
    else
      nil
    end
  end

end
