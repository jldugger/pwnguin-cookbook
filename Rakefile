# Rake tasks

require 'rake'
require 'fileutils'

##
# Run command wrapper
def run_command(command)
  if File.exist?('Gemfile.lock')
    sh %(bundle exec #{command})
  else
    sh %(CHEF_LICENSE="accept" chef exec #{command})
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

task :unit do
  run_command('rm -f Berksfile.lock')
  run_command('rspec --format documentation --color')
end

desc 'Run all tests'
task test: [:berks_update, :style, :lint]
task travis: [:style, :lint, :unit]

task default: :test
