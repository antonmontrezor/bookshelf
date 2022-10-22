class Mutations::CreateAuthor < GraphQL::Schema::Mutation
  null true

  argument :author, Types::AuthorInputType, required: true

  # this mutation is its own class, it doesn't have a resolver called create_author, but we can use the standart resolve method
  def resolve(author:)
    Author.create(author.to_h)
  end
end