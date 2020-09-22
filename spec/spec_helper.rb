# frozen_string_literal: true

require 'bundler/setup'
require 'doc_type_checker'

Dir[File.expand_path('support/*.rb', __dir__)].sort.each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

DocTypeChecker.configure do |config|
  config.enabled = true
  config.strict = true
  config.yard_run_arguments = ['--hide-void-return', 'spec/support/*']
end
