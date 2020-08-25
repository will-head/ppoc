# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

unless ENV["RAILS_ENV"] == "production"
  require "rambo"
  Rambo::Rake::Task.new
end

Rails.application.load_tasks
