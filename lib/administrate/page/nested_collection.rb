require 'administrate/page/collection'

module Administrate
  module Page
    class NestedCollection < Page::Collection
      def attribute_names
        options.fetch(:collection_attributes, dashboard.collection_attributes)
      end
    end
  end
end
