# frozen_string_literal: true

require "bundler/gem_tasks"
require "minitest/test_task"
require "rubocop/rake_task"

Minitest::TestTask.create(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_globs = FileList["test/**/test_*.rb"]
end

RuboCop::RakeTask.new

task default: %i[test rubocop]
