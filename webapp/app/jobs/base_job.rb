# Bring ActiveJob syntax to native Delayed Job class.
# Overcome the limitations of ActiveJob while retaining its API.
class BaseJob
  include Bugsnagable

  def self.perform_later *args
    if Rails.configuration.active_job.queue_adapter == :inline
      self.new.perform *args
    else
      self.new.delay.perform *args
    end
  end

  def self.set_max_attempts attempts, reschedule_interval = nil
    define_method :max_attempts do
      attempts
    end

    set_reschedule_interval reschedule_interval if reschedule_interval
  end

  def self.set_reschedule_interval interval
    define_method :reschedule_at do |current_time, attempts|
      current_time + interval
    end
  end

  def self.run_once
    self.set_max_attempts 1
  end

  self.set_reschedule_interval 30.seconds
end
