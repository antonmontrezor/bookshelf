module Types
  class MutationType < Types::BaseObject
   
    # thre are 2 ways to do mutations in rails

    #1 
    # field :create_author, Types::AuthorType, null: true, description: "Create an author" do
    #   # arguments have a very similar patterns to fields
    #   argument :first_name, String, required: false
    #   argument :last_name, String, required: false
    #   argument :yob, Int, required: false
    #   argument :is_alive, Boolean, required: false
    # end

    # def create_author(first_name:, last_name:, yob:, is_alive:)
    #   Author.create(first_name: first_name, last_name: last_name, yob: yob, is_alive: is_alive)
    # end

    #2 - it's a separate mutation file for each mutation
    field :create_author, Types::AuthorType, mutation: Mutations::CreateAuthor

    # (the secon argument is a return type) we don't need to return the Author object like we do in the field above since we now just need to confirm if an update was successfull or not
    field :update_author, Boolean, null: false, description: "Update an author" do
      argument :author, Types::AuthorInputType, required: true
    end

    def update_author(author:)
      existing = Author.where(id: author[:id].first)
      existing&.update(author.to_h)
    end

    field :delete_author, Boolean, null: false, description: "Delete an author" do
      # we only need an ID of an author to delete it
      argument :id, ID, required: true
    end

    def delete_author(id:)
      Author.where(id: id).destroy_all
      # returning true for all cases, not quite sure why we use it though
      true
    end
  end
end
