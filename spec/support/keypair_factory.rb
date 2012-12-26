require 'openssl'

module KeypairFactory
  mattr_accessor :available, :used
  self.available = []
  self.used = []

  def self.reserve(password = 'testing')
    (available.shift || create(password)).tap { |k| used << k }
  end

  def self.reset
    self.available += used
    used.clear
  end

  def self.find(public_key)
    used.detect { |keypair| keypair.public_key == public_key }
  end

private

  def self.create(password)
    Keypair.new(OpenSSL::PKey::RSA.new(1024), password)
  end

  class Keypair < Struct.new(:key, :password)
    def self.cipher
      @cipher ||= OpenSSL::Cipher::Cipher.new('des3')
    end

    def public_key
      key.public_key.to_pem
    end

    def private_key
      key.to_pem(self.class.cipher, password)
    end
  end

end