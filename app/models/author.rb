class Author < ApplicationRecord
  def full_name
    "#{first_name} #{last_name}"
  end

  # there's a created custom graphql type for these coordinates
  def coordinates
    [rand(90), rand(90)]
  end

  def publication_years
    (1...rand(10)).to_a.map {1900 - rand(100)}
  end

  #create a valiadation to test out handling validation errors
  validates :last_name, presence: true
end
