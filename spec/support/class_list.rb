# frozen_string_literal: true

module Blog
  # Blog::Post
  class Post
    class << self
      # @param [Integer] id
      # @param [String] title
      # @return [Blog::Post]
      def create(id:, title:)
        new(id, title, [])
      end
    end

    # @param [Integer] id
    # @param [String] title
    # @param [Array<Blog::Comment>] comments
    # @return [Blog::Post]
    def initialize(id, title, comments)
      @id = id
      @title = title
      @comments = comments
    end

    # @return [String]
    def inspect
      instance_variables.map { |var| "#{var}=#{instance_variable_get(var)}" }.join(', ')
    end

    # @note wrong return comment
    # @return [Integer]
    def id_to_string
      @id.to_s
    end

    # @return [Integer]
    def id_to_integer
      @id.to_i
    end
  end

  # Blog::Comment
  class Comment
    # @param [Integer] id
    # @param [String] body
    # @return [Blog::Comment]
    def initialize(id, body)
      @id = id
      @body = body
    end
  end
end
