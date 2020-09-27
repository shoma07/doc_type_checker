# frozen_string_literal: true

module DocTypeChecker
  # DocTypeChecker::Configuration
  module Configuration
    def configure
      @trace_point = DocTypeChecker::TracePoint.new
      yield self
    end

    # @param [TrueClass, FalseClass] enabled
    # @return [TrueClass, FalseClass]
    def enabled=(enabled)
      @trace_point.enabled = enabled
    end

    # @param [TrueClass, FalseClass] strict
    # @return [TrueClass, FalseClass]
    def strict=(strict)
      @trace_point.strict = strict
    end

    # @param [Logger, NilClass] logger
    # @return [Logger, NilClass]
    def logger=(logger)
      @trace_point.logger = logger
    end

    # @param [Array] arguments
    # @return [TrueClass, FalseClass]
    def yard_run_arguments=(arguments)
      YARD::CLI::CommandParser.run(*arguments)
    end
  end
end
