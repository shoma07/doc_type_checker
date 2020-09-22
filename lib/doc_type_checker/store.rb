# frozen_string_literal: true

module DocTypeChecker
  # DocTypeChecker::Store
  class Store
    # @return [DocTypeChecker::Store]
    def initialize
      reload!
    end

    # @param [String] class_name
    # @param [String] method_name
    # @return [DocTypeChecker::Definition]
    def fetch(class_name, method_name)
      @definitions.fetch(class_name, nil)&.fetch(method_name, nil)
    end

    # @return [Hash<String, Hash<String, DocTypeChecker::Definition>>]
    def reload!
      @definitions = YARD::Registry.load!.all(:class).to_h do |klass|
        [
          klass.path,
          klass.meths.to_h do |meth|
            [meth.name(true), DocTypeChecker::Definition.new(meth)]
          end
        ]
      end
    end
  end
end
