class MongoWowgram
    include Mongoid::Document
    field :description, type: String
    field :body, type: String
    field :user_id, type: Integer
end