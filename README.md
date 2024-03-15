# Administrate::Field::NestedHasMany

A plugin for nested has_many forms in [Administrate].

[Administrate]: https://github.com/thoughtbot/administrate

## Compatibility

This gem depends on Administrate APIs that may change over time. For this reason,
some versions of this gem will be compatible only with some versions of Administrate.

This is a table of known compatibilities. It is accurate to the best of our knowledge.
Please let us know if you detect other incompatibilities:

| `nested_has_many` | Administrate  |
|-------------------|---------------|
| v2.1.0            | v0.20.0       |
| v2.0.0            | up to v0.19   |
| v1.3.0            | up to v0.15   |
| `#726d8gc`        | from v0.16    |
| `master`          | up to v0.19.0 |

## Usage

Add to your `Gemfile`:

```ruby
gem "administrate-field-nested_has_many"
```

Run:

```bash
$ bundle install
```

Add to your `FooDashboard`:

```ruby
ATTRIBUTE_TYPES = {
  bars: Field::NestedHasMany.with_options(skip: :foo),
}
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

## Troubleshooting

### `undefined method 'new_record?' for nil:NilClass`

This field assumes that your models are setup for nested assignment as per
Rails conventions. For example, if you have a `Recipe` that
`has_many :ingredients`, you would have something like this:

```ruby
class Recipe < ApplicationRecord
  has_many :ingredients

  accepts_nested_attributes_for(
    :ingredients,
    reject_if: :all_blank,
    allow_destroy: true
  )
end
```

Specifically, you'll see this `new_record?` error if you forget the
`accepts_nested_attributes_for` declaration.
