class User < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true, on: :create
    validate :email_format, on: :create
    validates :password, length: { within: 6..27 }, on: :create
    validate :password_uppercase?, on: :create
    validate :special_character, on: :create
    before_save :downcase
    before_update :downcase
    has_secure_password  #.authenticate, .password=, validates

    def self.from_omni_auth(omni_response) #the block only gets activated on create
        self.find_or_create_by(uid: omni_response['uid'], provider: omni_response['provider']) do |u|
          u.first_name = omni_response['info']['first_name'].downcase
          u.last_name = omni_response['info']['last_name'].downcase
          u.email = omni_response['info']['email'].downcase
          u.password = SecureRandom.hex(12) + "C!" # still need this information, despite google handling login, random sequence that even we do not know for security
        end 
    end

    def full_name
      self.first_name.capitalize + " " + self.last_name.capitalize
    end

    def email_format
      self.errors.add(:email, 'must be valid') if !!self.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i 
    end

    def password_uppercase?
      errors.add(:password, 'must contain at least 1 uppercase ') if !!self.password =~ (/\p{Upper}/)
    end

    def downcase
      self.first_name = self.first_name.downcase
      self.last_name = self.last_name.downcase
      self.email = self.email.downcase
    end

    def special_character
      special = "?<>',?[]}{=-)(*&^%$#`~{}!"
      regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
      self.errors.add(:password, "must contain special character") if !!self.password =~ regex
    end

end
