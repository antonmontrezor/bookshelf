class Types::CoordinatesType < Types::BaseObject
  field :latitude, Float, null: true
  field :longitude, Float, null: true

  def latitude
    # in this case object is what coordinates resolver brings back in author.rb Active Record model file
    object.first
  end

  def longitude
    object.last
  end
end