require 'resque/tasks'
require 'resque_scheduler/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end

# desc "Alias for resque:work (To run workers on Heroku)"
# task "jobs:work" => "resque:work"
# task "resque:setup" => :environment
task "resque:scheduler_setup" => :environment


# had in procfile
# worker: QUEUE=* bundle exec rake resque:work
