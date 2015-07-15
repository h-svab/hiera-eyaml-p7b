require 'base64'
require 'hiera/backend/eyaml/encryptor'
require 'hiera/backend/eyaml/utils'
require 'hiera/backend/eyaml/plugins'
require 'hiera/backend/eyaml/options'

class Hiera
  module Backend
    module Eyaml
      module Encryptors
        class P7B < Encryptor

          VERSION = "0.1"

          self.tag = "P7B"

          self.options = {
            :private_key => { :desc => "Path to private key",
                              :type => :string,
                              :default => "~/.eyaml/ssl/private_key.pem" },
            :public_key  => { :desc => "Path to public key matching to private key",
                              :type => :string,
                              :default => "~/.eyaml/ssl/public_key.pem" },
            :public_keys => { :desc => "Array of paths to public keys",
                             :type => :string,
                             :default => "~/.eyaml/ssl/public_key.pem" },
            :subject => { :desc => "Subject to use for certificate when creating keys",
                          :type => :string,
                          :default => "/" },
          }

          def self.encrypt plaintext

            public_key_files = self.option :public_keys
            raise StandardError, "p7b_public_keys is not defined" unless public_key_files

            public_keys = public_key_files.split(',').map do |key_name|
              public_key_pem = File.read key_name
              OpenSSL::X509::Certificate.new( public_key_pem )
            end

            cipher = OpenSSL::Cipher::AES.new(256, :CBC)
            OpenSSL::PKCS7::encrypt(public_keys, plaintext, cipher, OpenSSL::PKCS7::BINARY).to_der

          end

          def self.decrypt ciphertext

            public_key = self.option :public_key
            private_key = self.option :private_key
            raise StandardError, "pkcs7_public_key is not defined" unless public_key
            raise StandardError, "pkcs7_private_key is not defined" unless private_key

            private_key_pem = File.read private_key
            private_key_rsa = OpenSSL::PKey::RSA.new( private_key_pem )

            public_key_pem = File.read public_key
            public_key_x509 = OpenSSL::X509::Certificate.new( public_key_pem )

            pkcs7 = OpenSSL::PKCS7.new( ciphertext )
            begin
              pkcs7.decrypt(private_key_rsa, public_key_x509)
            rescue
              nil
            end
          end

          def self.create_keys
            STDERR.puts "Create_keys not yet implemented in p7b encryptor!"
          end

        end
      end
    end
  end
end
