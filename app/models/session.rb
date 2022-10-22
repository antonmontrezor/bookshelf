class Session < ApplicationRecord

  belongs_to :user

  #adding a hook to a session model to authomatically create a key everytime it's saved
  #Is called before Base.save on new objects that haven’t been saved yet (no record exists).
  before_create do

    # A Random class has only 48 bits whereas SecureRandom can have up to 128 bits. So the chances of repeating in SecureRandom are smaller.
    # This library is an interface to secure random number generators which are suitable for generating session keys in HTTP cookies, etc. -> returns a hex of 40 characters
    # self here is Session
    self.key = SecureRandom.hex(40)
  end

end
