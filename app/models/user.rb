class User < ApplicationRecord

  #Adds methods to set and authenticate against a BCrypt password
  # https://bjpcjp.github.io/pdfs/rails/ch06-secure-password.pdf
  has_secure_password

  has_many :sessions

end
