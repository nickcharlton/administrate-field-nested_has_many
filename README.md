# Administrate::Field::NestedHasMany

A plugin for nested has_many forms in [Administrate].

## Usage

Add to your `Gemfile`:

```ruby
gem "administrate-field-nested_has_many", "~> 0.0.2"
```

Run:

```bash
$ bundle install
```

Add to your `FooDashboard`:
```ruby
ATTRIBUTE_TYPES = [
  bars: Field::NestedHasMany.with_options(skip: :foo),
]
```

The `skip` option takes a single symbol or list of symbols.
It will prevent the nested form from displaying the fields for those attributes.

If a `Customer` `has_many :orders`,
and you want to render `orders` as a nested form on the customer edit page,
then it is generally necessary to add `skip: :customer` to the options
for the `NestedHasMany` field.
Otherwise, Administrate will try to render a field
for the order's `:customer` attribute,
which breaks the nested form logic.

## Stopgap fix for javascript

At the moment, Administrate doesn't automatically load javascripts from plugins.
To fix this, you need to generate the Administrate javascript file:

```bash
$ rails g administrate:views:layout
```

And then add a line to `app/views/admin/application/_javascript.html.erb`
to input the javascript for this gem:

```
<%= javascript_include_tag "administrate-field-nested_has_many/application" %>
```

[Administrate]: https://github.com/thoughtbot/administrate
