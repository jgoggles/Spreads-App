# Delayed::Worker.sleep_delay = 60
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 5.minutes
Delayed::Worker.backend = :active_record
# Delayed::Job.attr_accessible :priority, :payload_object, :run_at 
