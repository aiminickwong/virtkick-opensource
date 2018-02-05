require 'openssl'
require 'securerandom'

module DoorbellHelper
  def doorbell_signature()
    secret = Rails.configuration.x.doorbell.secret
    return unless secret

    timestamp = Time.now.to_i
    token = SecureRandom.hex(50)
    signature = OpenSSL::HMAC.hexdigest \
        OpenSSL::Digest.new('sha256'),
        secret,
        '%s%s' % [timestamp, token]

    "timestamp: #{timestamp}, token: '#{token}', signature: '#{signature}', "
  end
end
