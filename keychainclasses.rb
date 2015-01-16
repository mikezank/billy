require 'openssl'
require 'pstore'
require 'uuidtools'
require_relative 'billdataclasses'

class Code
  
  def self.initialize_key
    # initialize the AES key to be used by all encryptions / decryptions
    words = %w(sheep goto heaven goats hell)
    letters = %w(5 7 $ @)
    @@AESkey = letters[0] + words[0] + words[1] + letters[1] + words[2] + 
      letters[2] + words[3] + words[1] + letters[3] + words[4]
  end
  
  #
  # message is the encrypted value of the Code
  #
  # iv is the initialization vector used for the encryption
  #
  def initialize(plaintext)
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    cipher.key = @@AESkey
    @iv = cipher.random_iv
    @message = cipher.update(plaintext) + cipher.final
  end
  
  def decode
    decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    decipher.decrypt
    decipher.key = @@AESkey
    decipher.iv = @iv
    decipher.update(@message) + decipher.final
  end
  
end

class Key
  
  attr_reader :name, :info, :coded, :codes, :uuid
  
  #
  # name is the name of the key
  #
  # info is an array containing the information field names for the key
  #
  # coded is a boolean array indicating whether the corresponding info field is encrypted
  #
  # codes is an array of the encrypted info field values
  #
  # plaintext is an array containing the decrypted plaintext for key initialization but is 
  # never stored in the key itself.  Instead, this information is encrypted and stored
  # as a Code value in codes.
  #
  # uuid is a randomly generated unique key to identify the Key
  #
  def initialize(name, info, coded, plaintext)
    unless info.length == coded.length && coded.length == plaintext.length
      puts "Cannot create new Key. info, coded, and plaintext arrays must be the same length"
      raise SystemExit
    end
    @name = name
    @info = info
    @coded = coded
    @codes = Array.new(@info.length, nil)
    @uuid = UUIDTools::UUID.random_create.to_str
    
    # encrypt coded info fields
    0.upto(@info.length-1) do |n|
      @codes[n] = Code.new(plaintext[n]) if @coded[n]
    end
  end
  
end

class KeyList
  
  KEYS_PSTORE = 'keychain.pstore'
  
  #
  # keys is hash of Key indexed by Key uuid (key names do not have to be unique)
  #
  def initialize
    prefs = Preferences.new
    @pstore = PStore.new(prefs.data_directory + '/' + KEYS_PSTORE)
    @pstore.transaction do
      @keys = @pstore.fetch(:keys, {})
    end
  end
  
  def add_key(key)
    @keys[key.uuid] = key
    save_keys
  end
  
  def get_key(uuid)
    unless @keys.has_key?(uuid)
      puts "Cannot get key with uuid #{uuid}"
      raise SystemExit
    end
    @keys[uuid]
  end
  
  def delete_key(key)
    unless @keys.has_key?(key.uuid)
      puts "Cannot delete key with uuid #{key.uuid}"
      raise SystemExit
    end
    @keys.delete(key.uuid)
    save_keys
  end
  
  def save_keys
    @pstore.transaction do
      @pstore[:keys] = @keys
    end
  end
  
  def length
    @keys.length
  end
  
  def each_key
    @keys.sort_by {|k, key| key.name}.each {|k, key| yield key}
  end
  
end
    
  
  