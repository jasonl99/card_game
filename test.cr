require "digest/sha1"
ALPHABET = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
BASE = ALPHABET.size.to_u64

strings = %w(these are some random words to test what sort of result we'll end up with)

strings.map do |str|
  sha_digest = Digest::SHA1.digest str
  values = sha_digest.first(8).map_with_index do | unit, index |
    index == 0 ? unit : (BASE ** index) * unit
  end	
  puts ({str,values.sum})
end
