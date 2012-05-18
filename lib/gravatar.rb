require 'digest/md5'

module Gravatar

  def gravatar_id
    Digest::MD5.hexdigest(self.email.to_s.downcase)
  end
  
  def gravatar_url(options = { rating: 'g'})
    "https://secure.gravatar.com/avatar/#{self.gravatar_id}.png/rating=#{options[:rating]}"
  end

end