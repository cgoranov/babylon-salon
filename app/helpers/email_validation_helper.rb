class EmailValidator < ActiveModel::Validator
    def validate(record)
        unless record =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
            record.errors[:email] << "is not an email"
        end
    end
  end