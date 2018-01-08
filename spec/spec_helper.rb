require "bundler/setup"
require "self_updated_at"
require 'database_cleaner'
RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
  require File.expand_path('../../lib/self_updated_at', __FILE__)

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.raise_errors_for_deprecations!
end
