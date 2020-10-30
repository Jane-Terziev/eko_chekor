module Regex
  class Email
    def self.VALID_EMAIL_REGEX
      /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    end

    def self.downcase_email(email)
      email.downcase
    end
  end
end