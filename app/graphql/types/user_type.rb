class Types::UserType < Types::BaseObject
  description "A user"

  field :id, ID, null: true
  field :email, String, null: true
  field :is_superadmin, Boolean, null: true

  #the concept of visibility (https://graphql-ruby.org/authorization/visibility.html) when a certain part of graphQl schema could be hidden for certain users
  def self.visible?(context)
    # !! used to convert a value to boolean
    !!context[:current_user]
  end
end