if Rails.env.production? and not ENV['SECRET_KEY_BASE']
  raise 'Set the SECRET_KEY_BASE environment variable for production.'
end
