require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

desc 'Default: run spec'
task default: :spec

desc 'Copy sample spec database.yml over if not exists'
task :copy_db_config do
  cp 'spec/dummy/config/database.yml.sample', 'spec/dummy/config/database.yml'
end

task spec: [:copy_db_config]
