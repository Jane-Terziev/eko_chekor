require_relative '../optional'

module Pagination
  class PageRequest
    attr_reader :page, :size

    def initialize(page, size)
      self.page = page
      self.size = size
    end

    def offset
      (page - 1) * size
    end

    def sort
      {}
    end

    def to_optional
      Optional.of(self)
    end

    def ==(other)
      page == other.page && size == other.size
    end

    alias eql? ==

    def hash
      [page, size].hash
    end

    private

    attr_writer :page, :size
  end
end
