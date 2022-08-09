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

        initializer "administrate-field-nested_has_many.assets.precompile" do |app|
          app.config.assets.precompile += [
            "administrate-field-nested_has_many/application.js",
            "administrate-field-nested_has_many/application.css",
          ]
        end
      end

      DEFAULT_ATTRIBUTES = %i(id _destroy).freeze

      def nested_fields
        associated_form.attributes.reject do |nested_field|
          skipped_fields.include?(nested_field.attribute)
        end
      end

      def nested_fields_for_builder(form_builder)
        return nested_fields unless form_builder.index.is_a? Integer

        nested_fields.each do |nested_field|
          next if nested_field.resource.blank?

          # inject current data into field
          resource = data[form_builder.index]
          nested_field.instance_variable_set(
            "@data",
            resource.send(nested_field.attribute),
          )
        end
      end

      def to_s
        data
      end

      def self.dashboard_for_resource(resource_class, attr)
        "#{associated_class_name(resource_class, attr)}Dashboard".constantize
      end

      def self.associated_attributes(resource_class, attr)
        dashboard_class = dashboard_for_resource(resource_class, attr)
        DEFAULT_ATTRIBUTES + dashboard_class.new.permitted_attributes
      end

      def self.permitted_attribute(attr, options = {})
        given_class_name = options[:class_name]
        _resource_class =
          if given_class_name
            Administrate.warn_of_deprecated_option(:class_name)
            given_class_name.classify
          else
            options[:resource_class]
          end

        {
          "#{attr}_attributes".to_sym =>
            associated_attributes(_resource_class, attr),
        }
      end

      def associated_class_name
        self.class.associated_class_name(resource.class, attribute)
      end

      def association_name
        options.fetch(:association_name) do
          associated_class_name.underscore.pluralize[/([^\/]*)$/, 1]
        end
      end

      def associated_form
        Administrate::Page::Form.new(associated_dashboard, new_resource)
      end

      private

      def new_resource
        @new_resource ||= associated_class.new
        @new_resource[foreign_key] = resource.send(primary_key)
        @new_resource
      end

      def skipped_fields
        Array(options[:skip])
      end
    end
  end
end
