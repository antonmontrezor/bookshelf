module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator" do
      argument :name, String, required: true
    end

    # resolver
    def test_field(name:)
      Rails.logger.info context[:time]
      "Hello #{name}!"
    end

    # using a newly created Types::AuthorType class to return specifically templated data
    field :author, Types::AuthorType, null: true, description: "Returns one Author instance" do
      # this argument is required
      argument :id, ID, required: true
    end

    def author(id:)
      # quering db to bring back the first author (possible without .first)
      Author.where(id: id).first
    end

    # creating a field for a higher type of arrays (not like the publish dates array I created)
    field :authors, [Types::AuthorType], null: false

    def authors
      Author.all
    end
  end
end
