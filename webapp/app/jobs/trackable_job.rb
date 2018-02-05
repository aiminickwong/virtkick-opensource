class TrackableJob < BaseJob
  def initialize progress_id
    @progress_id = progress_id
  end

  def success job
    Progress.find(@progress_id).update! finished: true
  end

  def failure job, e
    Progress.find(@progress_id).update! finished: true, error: e.message
    super
  end

  def self.perform_later user, *args
    progress = Progress.new
    progress.user_id = user.is_a?(Integer) ? user : user.id
    progress.save!

    job = self.new progress.id
    job.delay.perform *args

    progress.id
  end
end
