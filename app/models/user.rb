class User < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
    validate :email_format
    has_secure_password  #.authenticate, .password=, validates

    def self.from_omni_auth(omni_response) #the block only gets activated on create
        self.find_or_create_by(uid: omni_response['uid'], provider: omni_response['provider']) do |u|
          u.first_name = omni_response['info']['first_name']
          u.last_name = omni_response['info']['last_name']
          u.email = omni_response['info']['email']
          u.password = SecureRandom.hex(15) # still need this information, despite google handling login, random sequence that even we do not know for security
        end 
    end

    def email_format
      unless self.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
          self.errors.add(:email, "Must be valid email")
      end
    end

end
