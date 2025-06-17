# DataFields


Define and add user-defined fields to your ActiveRecord models.  

## Usage

Run the migrations within your Rails application: 

```sh 
bin/rails db:migrate:standard_procedure_data_fields
```

This will create the tables for your data fields.  

Then, choose which models will hold your Definitions and which will hold your DataValues.  For example, if you are building custom forms, you may have a `FormTemplate` model that holds the Definitions and a `Form` model that holds the DataValues.  

Therefore, in your Form Template, you would use: 

```ruby
class FormTemplate < ApplicationRecord
  has_many :field_definitions, -> { form_field_definition.order :position }, class_name: "DataFields::Field", dependent: :destroy
  accepts_nested_attributes_for :field_definitions
end
```

And in your Form, you would use: 

```ruby
class Form < ApplicationRecord
  has_many :field_values, -> { data_value.order :position }, class_name: "DataFields::Field", dependent: :destroy
  accepts_nested_attributes_for :field_values
end
```

The `accepts_nested_attributes_for` is not necessary but is useful in your user-interface.  

Then, once your users have built a FormTemplate, you can create a Form from it by using something like:

```ruby
@form = @form_template.create_form(...)
@form_template.field_definitions.each do |field_definition|
  field_definition.copy_into @form.field_values, data_field_type: "data_value"
end
```

## Data Fields

DataFields fall in to two categories:

### Definitions

A Definition is, as it sounds, the template for a data-field.  It defines the type, whether it is `required?` or not, the field name, an optional description, plus extras like the list of valid `options` for types such as `Select` or `MultiSelect`.  However, a Definition does not carry a `value`.  

### Data Values

A Data Value is built from a Definition and _copies_ the specification into a new record.  The new record can then store a value - how this is stored depends upon the type of field (`Text` stores it in the `JSON` data field, `Image` stores it using ActiveStorage etc).  

The reason the Definition is copied into the DataValue, as opposed to the expected foreign key relationship, is because, over time, the Definition may change.  However, we do not want existing DataValues to change, as they form part of the historical record.  So, if it is decided to change a Definition's field name, this has no effect on the DataValues that were previously built from that Definition.  

## Installation
Add this line to your application's Gemfile:

```ruby
gem "standard_procedure_data_fields"
```

## License
The gem is available as open source under the terms of the [LGPL License](/LICENCE).
