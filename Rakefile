# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |task|
  task.warning = false
  task.libs = ["lib", "test"]
  task.test_files = FileList["lib/**/*_test.rb"]
end

task default: :test
