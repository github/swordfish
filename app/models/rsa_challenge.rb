require 'openssl'

module RsaChallenge
  module Encryption
    def decrypt(value)
      crypt(:decrypt, value).split('--')
    rescue OpenSSL::Cipher::CipherError
      nil
    end

    def crypt(cipher_method, value) #:nodoc:
      cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')
      cipher.send(cipher_method)
      cipher.pkcs5_keyivgen(ENV['AUTH_KEY'])
      result = cipher.update(value)
      result << cipher.final
    end
  end

  class Request
    def initialize(key)
      @public_key = OpenSSL::PKey::RSA.new(key)
    end

    def value
      Base64.encode64 @public_key.public_encrypt(encrypted_challenge_values)
    end

    def user
      @user ||= find_user || create_user
    end

  private

    include Encryption

    def challenge_values
      [user.id, ENV["AUTH_SECRET"], Time.now.to_f]
    end

    def encrypted_challenge_values
      crypt :encrypt, challenge_values.join('--')
    end

    def find_user
      User.first(:fingerprint => @public_key.fingerprint)
    end

    def create_user
      User.create!(:public_key => @public_key.to_s)
    end
  end

  class Response
    include Encryption

    attr_reader :user_id

    def initialize(value)
      @value = value
    end

    def valid?
      @user_id, secret, time = decrypt(Base64.decode64(@value))
      secret == ENV["AUTH_SECRET"]
    end
  end
end
