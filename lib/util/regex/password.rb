module Regex
  class Password
    def self.VALID_PASSWORD_REGEX
      /^[a-zA-Z0-9]{8,}*$/
    end
  end
end
