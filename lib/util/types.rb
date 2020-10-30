require 'util/regex/email'
require 'util/regex/password'
require 'util/pagination/page_request'

module Types
  include Dry::Types()

  Email             = Types::String.constructor(&:downcase).constrained(format: Regex::Email.VALID_EMAIL_REGEX)
  StrippedString    = Types::String.constructor(&:strip)

  PageRequest = Types.Instance(Pagination::PageRequest)
end
