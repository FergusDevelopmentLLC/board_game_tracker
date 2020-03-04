class User < ActiveRecord::Base
    has_secure_password
    
    validates :username, :presence => true, 
                         :uniqueness => true
    validates_presence_of :email
    validates_format_of :email, :with => /\w+@\w+\.\w+/
    validates_presence_of :password
end