class User
  module PasswordReset
    def password_reset_token_expired?
      self.password_reset_sent_at < 2.hours.ago
    end

    def reset_password_reset_fields
      self.password_reset_sent_at = nil
      self.password_reset_token   = nil
      self.save!
    end

    def set_password_reset_fields
      generate_token(:password_reset_token)
      self.password_reset_sent_at = Time.zone.now
      self.save!
    end
  end
end