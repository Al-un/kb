---
tech: rails
title: Active Storage
sources:
  - name: Rails API docs
    link: https://api.rubyonrails.org/
mentioned:
  - /2018/12/19/active-storage
---

sources:

- https://www.engineyard.com/blog/active-storage
- https://edgeguides.rubyonrails.org/active_storage_overview.html

## Installation & configuration

Create storage tables:

```shell
rails active_storage:install
rails db:migrate
```

Configuration:

```yaml
# config/storage.yml
local:
  service: Disk
  root: <%= Rails.root.join("storage") %>

test:
  service: Disk
  root: <%= Rails.root.join("tmp/storage") %>

amazon:
  service: S3
  access_key_id: ""
  secret_access_key: ""
  region: ""
  bucket: ""
```

Declare configuration per environments:

```ruby
# config/environments/development.rb
config.active_storage.service = :local

# config/environments/test.rb
config.active_storage.service = :test

# config/environments/production.rb
config.active_storage.service = :amazon
```

## Handling attachments

### In ActiveRecords

Update models:

```ruby
class Catalog < ApplicationRecord
  has_one_attached :picture
end

class Article < ApplicationRecord
  has_many_attached :pictures
end
```

### Rails forms

In forms files:

```ruby
# in catalog forms
<%= f.file_field :picture %>

# in article forms
<%= f.file_field :picture, multiple: true %>
```

In controllers:

```ruby
# Catalog controller
class CatalogsController
  # Filter catalogs parameters
  def catalog_params
    params.require(:catalog).permit(:other_fields, :picture)
  end
end


# Article controller
class ArticlesController
  def update_entity
    article = Article.find(params[:id])
    article.update(article_params)
    article.pictures.attach(params[:pictures])

    article
  end

  # Filter articles parameters
  def article_params
    params.require(:article).permit(:other_fields, pictures: [])
  end
end

```

### Rails views

**Conditional rendering**

To check if picture has an attachment, use `picture.attached?` or check
`picture.attachment.nil?`. `image_tag` is an useful helper for rendering an
`<img />` tag.

**Single picture**

```ruby
# in some helper file
def display_picture(picture)
    return 'no picture' if picture.attachment.nil?

    image_tag picture
end
```

More about [`image_tag`](https://apidock.com/rails/ActionView/Helpers/AssetTagHelper/image_tag)

**Multiple pictures**

```ruby
<% article.pictures.each do |picture| %>
  <%= image_tag picture, height: '200', alt: article.name + ' picture', title: article.name %>
<% end %>
```

## Serialization

```ruby
class CatalogSerializer < ActiveModel::Serializer
  # optional attributes
  attribute :picture_url, if: -> { object.picture.attached? }

  def picture_url
    Rails.application.routes.url_helpers.rails_blob_path(object.picture, only_path: true)
  end
end
```

## Multiple picture:

- use `has_many_attached`
- input form allows multiple upload: `<%= f.file_field :pictures, multiple: true %>`
- strong parameters is an array: `permit(pictures: [])`
- update must attach new pictures: `article.pictures.attach(params[:pictures])`

## AWS

https://medium.com/alturasoluciones/setting-up-rails-5-active-storage-with-amazon-s3-3d158cf021ff

region name: https://docs.aws.amazon.com/general/latest/gr/rande.html

do not forget `aws-sdk-s3` gem
