# frozen_string_literal: true

module DocTypeChecker
  # DocTypeChecker::Definition
  class Definition
    attr_reader :name, :params, :ret

    # @param [YARD::CodeObjects::MethodObject] method_object
    # @return [DocTypeChecker::Definition]
    def initialize(method_object)
      @name = method_object.path
      init_params(method_object)
      init_return(method_object)
    end

    # @param [Hash<Symbol, Class>] arguments
    # @return [Array<String>]
    def validate_params(arguments)
      params.filter_map do |key, value|
        object = arguments[key]
        unless value.valid_type(object)
          "#{name}: #{key} isn't any of #{value.inspect_type}. actual type is #{object.class}"
        end
      end
    end

    # @param [Object] object
    # @return [String, NilClass]
    def validate_return(object)
      return if !ret.types.empty? && ret.valid_type(object)

      "#{name}: return value isn't any of #{ret.inspect_type}. actual type is #{object.class}"
    end

    private

    # @param [YARD::CodeObjects::MethodObject] method_object
    # @return [Hash<Symbol, DocTypeChecker::TagType>]
    # @raise [ArgumentError]
    def init_params(method_object)
      @params = method_object.tags.filter_map do |tag|
        [tag.name.to_sym, TagType.new(tag)] if tag.tag_name == 'param'
      end.to_h
      unless @params.empty? || @params.keys == actual_params_definition(method_object)
        raise ArgumentError, "#{name}: params doesn't match actual arguments"
      end

      @params
    end

    # @param [YARD::CodeObjects::MethodObject] method_object
    # @return [Array<Symbol>]
    def actual_params_definition(method_object)
      method_object.parameters.map { |param| param.first.sub(/:\z/, '').to_sym }
    end

    # @param [YARD::CodeObjects::MethodObject] method_object
    # @return [DocTypeChecker::TagType]
    def init_return(method_object)
      @ret =
        TagType.new(
          YARD::Tags::Tag.new(
            'return',
            '',
            method_object.tags.filter_map { |tag| tag.types if tag.tag_name == 'return' }.flatten
          )
        )
    end
  end
end
