---
tech: rails
title: Serialization
tags: [rails, json, serialization]
sources:
  - name: Active Model Serializers 0.10.x guides
    link: https://github.com/rails-api/active_model_serializers/tree/v0.10.6/docs
mentioned:
  - /2018/12/06/active-model-serializers
---

To customize JSON output, especially when Rails is used as an API endpoint. To 
add gem:

```
gem 'active_model_serializers', '~> 0.10.0'
```

## CLI
CLI command is available:
```
rails generate serializer article
```
generate `app/serializers/article_serializer.rb`

## Attributes

### Definitions

Attributes can either be declared in a bulky way via `attributes :field1, :field2...` or
one by one:
```ruby
attribute :field1
attribute :field2
```

### Conditional attributes
It requires the single attribute declaration:
```ruby
attribute :description, unless: -> { object.description.nil? }
attribute :some_field, if -> { some_condition }
```

### Computed attribute
Use a method to return the value. 

```ruby
attribute :article_count

def article_count
  object.articles.size
end
```

> Beware of N+1 queries

### Restrictions
Use the `field` options when using `json` adapter:
```ruby
# Exclude :description field
render json: @list, each_serializer: CatalogSerializer, fields: [:id, :code, :name]
```
This restriction also apply to computed attributes

## Associations

### Definitions
Associations are declared in a similar way of ActiveRecords:
```ruby
belongs_to :user
has_many :article_publications
```
If not specified, default serializers will be used for serializing relationship

### Restrictions
Use the `include` options when using the `json` adapter:
```ruby
# With the above definition, :article_publicaitons is excluded
render json: @list, each_serializer: CatalogSerializer, include: [:user]
```

## Misc

### Serializer class

Initialize function:
```ruby
def initialize(object, options = {})
end
```
- [`options` are copied into `@instance_options`](https://stackoverflow.com/a/37956952/4906586)