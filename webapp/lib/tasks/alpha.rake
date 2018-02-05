namespace :alpha do
  desc 'Remove old virtual machines and accounts'
  task cleanup: :environment do
    User.guest.to_delete.each do |user|
      begin
        puts user.email
        user.destroy
      rescue Exception => e
        puts "#{e.class}: #{e.message}"
        Bugsnag.notify_or_ignore e
      end
    end
  end
end
