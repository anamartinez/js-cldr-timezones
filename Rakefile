require "bundler/gem_tasks"
require "bump/tasks"
require "js_cldr/timezones"

task :default do
  sh "rspec spec/"
end

task :generate_timezones do
  JsCldr::Timezones.generate_timezones
end
