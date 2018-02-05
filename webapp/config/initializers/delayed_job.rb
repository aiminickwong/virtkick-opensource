Delayed::Worker.destroy_failed_jobs = Rails.env.development?
Delayed::Worker.sleep_delay = 0.5
Delayed::Worker.max_attempts = 1

if Rails.configuration.active_job.queue_adapter == :inline
  Delayed::Worker.delay_jobs = false

  # https://github.com/collectiveidea/delayed_job/issues/724
  module Delayed::Backend::Base
    def invoke_job
      Delayed::Worker.lifecycle.run_callbacks(:invoke_job, self) do
        begin
          hook :before
          payload_object.perform
          hook :success
        rescue => e
          hook :error, e
          hook :failure, e unless Delayed::Worker.delay_jobs
          raise e
        ensure
          hook :after
        end
      end
    end
  end
end
