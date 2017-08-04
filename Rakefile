# Rake tasks

require 'rake'
require 'fileutils'

##
# Run command wrapper
def run_command(command)
  if File.exist?('Gemfile.lock')
    sh %(bundle exec #{command})
  else
    sh %(chef exec #{command})
  end
end

require 'rubocop/rake_task'
desc 'Run RuboCop (style) tests'
RuboCop::RakeTask.new(:style)

desc 'Run FoodCritic (lint) tests'
task :lint do
  run_command('foodcritic --epic-fail any .')
end

desc 'Update Berkshelf'
task :berks_update do
  run_command('berks update')
end

desc 'Run all tests'
task test: [:berks_update, :style, :lint]

task default: :test
