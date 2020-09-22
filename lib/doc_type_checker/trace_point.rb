# frozen_string_literal: true

module DocTypeChecker
  # DocTypeChecker::TracePoint
  class TracePoint
    attr_writer :logger, :strict

    # @return [DocTypeChecker::TracePoint]
    def initialize
      @logger = nil
      @strict = false
      @store = DocTypeChecker::Store.new
      init_trace_point
    end

    # @param [TrueClass, FalseClass] enabled
    # @return [TrueClass, FalseClass]
    def enabled=(enabled)
      enabled ? @trace_point.enable : @trace_point.disable
    end

    private

    # @return [TracePoint]
    def init_trace_point
      @trace_point = ::TracePoint.new(:call, :return) do |trace_point|
        case trace_point.event
        when :call
          trace_event(trace_point)
        when :return
          trace_return(trace_point) if trace_point.method_id != :initialize
        end
      end
    end

    # @param [TracePoint] trace_point
    # @return [String]
    def trace_event(trace_point)
      definition = fetch_definition(trace_point)
      return if definition.nil?

      errors = definition.validate_params(event_arguments(trace_point))
      trace_error(errors.join("\n")) unless errors.empty?
    end

    # @param [TracePoint] trace_point
    def trace_return(trace_point)
      definition = fetch_definition(trace_point)
      return if definition.nil?

      error = definition.validate_return(trace_point.return_value)
      trace_error(error) unless error.nil?
    end

    # @param [String] error
    # @return [String]
    # @raise [DocTypeChecker::Error]
    def trace_error(error)
      info(error)
      raise Error, error if @strict
    end

    # @param [TracePoint] trace_point
    # @return [Hash<Symbol, Class>]
    def event_arguments(trace_point)
      binding = trace_point.binding
      binding.local_variables.to_h { |name| [name, binding.local_variable_get(name)] }
    end

    # @param [TracePoint] trace_point
    # @return [DocTypeChecker::Definition]
    def fetch_definition(trace_point)
      @store.fetch(
        trace_point.defined_class.name,
        "#{'#' unless trace_point.self.is_a?(Class)}#{trace_point.method_id}"
      )
    end

    # @param [String] message
    # @return [String]
    def info(message)
      return if @logger.nil?

      @logger.info(message)
    end
  end
end
