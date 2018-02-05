module Bugsnagable
  def failure job, e
    unless Rails.env.test?
      puts e.message
      puts e.backtrace.map { |e| '    ' + e }.join "\n"
    end
    Bugsnag.notify_or_ignore e
  end
end
