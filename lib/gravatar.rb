require 'digest/md5'

# @author Zamith
# This module provides helper methods to be include in a class which has an email
# such as User
module Gravatar

  # Generates the gravatar id from the object's email
  # @return [String] gravatar id
  def gravatar_id
    Digest::MD5.hexdigest(self.email.to_s.downcase)
  end
  
  # Generates the full gravatar url for the user (always uses https)
  # @param [Hash] options The only available option is the avatar rating you which to fetch
  # @return [String] gravatar url
  def gravatar_url(options = { rating: 'g'})
    "https://secure.gravatar.com/avatar/#{self.gravatar_id}.png/rating=#{options[:rating]}"
  end

end