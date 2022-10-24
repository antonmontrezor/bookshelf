class Types::AuthorType < Types::BaseObject
  description "One author"

  # Using scalar types that come with GraphQl library

  # 3 required arguments for the field -> name, type, nullability (for the query field when null: false graphql cannot return data which is null if author yob is nil in db)
  field :id, ID, null: false
  field :first_name, String, null: true
  field :last_name, String, null: true
  field :yob, Int, null: false
  field :is_alive, Boolean, null: true
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  
  # a custom field coming from author.rb (calling a method full_name from author.rb)
  field :full_name, String, null: true

  #another way to make a customized active record field
  # create a resolver method for a field
  field :custom_nickname, String, null: true

  def custom_nickname
    # object is an object that is Author active record object (in this case coming from 
    # ---> "author" method in query_type.rb, we make a query to db, get that object and get these variables like first_name and id
    "#{object.id} #{object.first_name}"
  end

  field :coordinates, Types::CoordinatesType, null: false

  # the type is array of integers as we are using the array of integers when returning a value from the resolver method
  field :publication_years, [Int], null: false

  field :errors, [Types::ErrorType], null: true

  def errors
    object.errors.map { |e| { field_name: e.attribute, errors: object.errors[e.attribute]} }
  end

  # this is the concept of authorization (https://graphql-ruby.org/authorization/authorization.html)
  # to be able to retrieve only an author which passed away
  def self.authorized?(object, context)
    !object.is_alive?
  end
end

class Types::AuthorInputType < GraphQL::Schema::InputObject
  # the name is what seen by the front-end client, for ex graphiql
  # if we want it not to be nilable, when we call this type in graphiql, it's needed to include "!" like so mutation createAuthor($author:AuthorInputType!) {
  graphql_name "AuthorInputType"
  description "All the attributes needed to create/update an author"

  # we need to specify an id of an author to make sure we update the right author
  argument :id, ID, required: false
  argument :first_name, String, required: false
  argument :last_name, String, required: false
  argument :yob, Int, required: false
  argument :is_alive, Boolean, required: false
end