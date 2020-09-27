# frozen_string_literal: true

module DocTypeChecker
  # DocTypeChecker::TagType
  class TagType
    ALLOW_TAG_NAMES = %w[param return].freeze
    attr_reader :types

    # @param [YARD::Tags::Tag] tag
    # @return [DocTypeChecker::TagType]
    def initialize(tag)
      raise ArgumentError unless ALLOW_TAG_NAMES.include?(tag.tag_name)

      @types = tag.types.to_a.flat_map.filter_map { |type_comment| const_get(type_comment) }
    end

    # @param [Object] object
    # @return [TrueClass, FalseClass]
    def valid_type(object)
      types.any? { |type| object.is_a?(type) }
    end

    # @return [String]
    def inspect_type
      types.join(', ')
    end

    private

    # @todo support definition Array<Integer>
    # @param [String] type_comment
    # @return [Class, NilClass]
    def const_get(type_comment)
      return if type_comment == 'void'
      return [TrueClass, FalseClass] if type_comment == 'Boolean'

      type_comment.match(/\A([\w:]+)(<.+>)?\z/) do
        Object.const_get(Regexp.last_match(1))
      end || (raise ArgumentError, "#{type_comment} isn't matched class")
    end
  end
end
