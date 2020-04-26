require "administrate/field/has_many"
require "administrate/page/form"
require "rails"
require "administrate/engine"
require "administrate/version"
require "cocoon"

module Administrate
  module Field
    class NestedHasMany < Administrate::Field::HasMany
      class Engine < ::Rails::Engine
        Administrate::Engine.add_javascript(
          "administrate-field-nested_has_many/application",
        )
        Administrate::Engine.add_stylesheet(
          "administrate-field-nested_has_many/application",
        )
      end

      DEFAULT_ATTRIBUTES = %i(id _destroy).freeze

      def nested_fields(object=nil)
        associated_form(object).attributes.reject do |nested_field|
          skipped_fields.include?(nested_field.attribute)
        end
      end

      def nested_fields_for_builder(form_builder)
        fields = nested_fields(form_builder.object)

        return fields unless form_builder.index.is_a? Integer

        fields.each do |nested_field|
          next if nested_field.resource.blank?

          # inject current data into field
          resource = if form_builder.object.nil?
                       nested_field.resource[form_builder.index]
                     else
                       nested_field.resource
                     end
          nested_field.instance_variable_set(
            "@data",
            resource.send(nested_field.attribute),
          )
        end
      end

      def to_s
        data
      end

      def self.dashboard_for_resource(resource, options)
        class_name = options && options[:class_name] || resource.to_s.classify
        "#{class_name}Dashboard".constantize
      end

      def self.associated_attributes(associated_resource, options)
        dashboard_class = dashboard_for_resource(associated_resource, options)
        DEFAULT_ATTRIBUTES + dashboard_class.new.permitted_attributes
      end

      def self.permitted_attribute(associated_resource, options = nil)
        {
          "#{associated_resource}_attributes".to_sym =>
          associated_attributes(associated_resource, options),
        }
      end

      def associated_class_name
        options.fetch(:class_name, attribute.to_s.singularize.camelcase)
      end

      def association_name
        options.fetch(
          :association_name,
          associated_class_name.underscore.pluralize[/([^\/]*)$/, 1],
        )
      end

      def associated_form(object=nil)
        resource = object || data.present? && data || resolver.resource_class.new
        Administrate::Page::Form.new(associated_dashboard, resource)
      end

      private

      def resolver
        @resolver ||=
            Administrate::ResourceResolver.new("admin/#{associated_class_name}")
      end

      def skipped_fields
        Array(options[:skip])
      end
    end
  end
end
