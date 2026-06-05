class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  # def serialize(resource, serializer)
  #   serializer.new.serialize(resource).to_json
  # end

  # def serialize_many(collection, serializer)
  #     Panko::ArraySerializer.new(collection, each_serializer: serializer).to_a
  # end

  # def paginate(collection, serializer)
  #     {
  #         items: serialize_many(collection, serializer), 
  #         meta: {
  #             current_page: collection.current_page,
  #             next_page: collection.next_page,
  #             prev_page: collection.prev_page,
  #             total_pages: collection.total_pages,
  #             total_count: collection.total_count
  #         }
  #     }
  # end
end
