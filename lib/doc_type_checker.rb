# frozen_string_literal: true

require 'tracer'
require 'yard'
require 'doc_type_checker/version'
require 'doc_type_checker/store'
require 'doc_type_checker/trace_point'
require 'doc_type_checker/configuration'
require 'doc_type_checker/tag_type'
require 'doc_type_checker/definition'

# DocTypeChecker
module DocTypeChecker
  # DocTypeChecker::Error
  class Error < StandardError; end
  extend Configuration
end
