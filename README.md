# PageMeta

[![Travis-CI](https://travis-ci.org/fnando/page_meta.png)](https://travis-ci.org/fnando/page_meta)
[![Code Climate](https://codeclimate.com/github/fnando/page_meta/badges/gpa.svg)](https://codeclimate.com/github/fnando/page_meta)
[![Test Coverage](https://codeclimate.com/github/fnando/page_meta/badges/coverage.svg)](https://codeclimate.com/github/fnando/page_meta/coverage)
[![Gem](https://img.shields.io/gem/v/page_meta.svg)](https://rubygems.org/gems/page_meta)
[![Gem](https://img.shields.io/gem/dt/page_meta.svg)](https://rubygems.org/gems/page_meta)

Easily define `<meta>` and `<link>` tags. I18n support for descriptions, keywords and titles.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "page_meta"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install page_meta

## Usage

Your controller and views have an object called `page_meta`. You can use it to define meta tags and links. By default, it will include the encoding and language meta tags.

```html
<meta charset="utf-8">
<meta name="language" content="en">
<meta itemprop="language" content="en">
```

You can use I18n to define titles, descriptions and keywords. These values will be inferred from the controller and action names. For an action `SiteController#index` you'll need the following translation scope:

```yaml
page_meta:
  titles:
    base: "%{value} • MyApp"
    site:
      index: "Welcome to MyApp"
```

The title can without the `base` context can be accessed through `page_meta.title.simple`.

```erb
<%= page_meta.title %>          // Welcome to MyApp • MyApp
<%= page_meta.title.simple %>   // Welcome to MyApp
```

Sometimes you need to render some dynamic value. In this case, you can use the I18n placeholders.

```yaml
en:
  page_meta:
    titles:
      base: "%{title} • MyCompany"
      workshops:
        show: "%{name}"
```

You can then set dynamic values using the `PageMeta::Base#[]=`.

```ruby
class WorkshopsController < ApplicationController
  def show
    @workshop = Workshop.find_by_permalink!(params[:permalink])
    page_meta[:name] = @workshop.name
  end
end
```

Some actions are aliased, so you don't have to duplicate the translations:

* Action `create` points to `new`
* Action `update` points to `edit`
* Action `destroy` points to `remove`

The same concept is applied to descriptions and keywords.

```yaml
en:
  page_meta:
    descriptions:
      site:
        home: MyApp is the best way of doing something.

    keywords:
      site:
        home: "myapp, thing, other thing"
```

### Defining meta tags

To define other meta tags, you have to use `PageMeta::Base#tag` like the following:

```ruby
class Workshops Controller < ApplicationController
  def show
    @workshop = Workshop.find_by_permalink(params[:permalink])
    page_meta.tag :description, @workshop.description
    page_meta.tag :keywords, @workshop.tags
  end
end
```

You can define default meta/link tags in a `before_action`:

```ruby
class ApplicationController < ActionController::Base
  before_action :set_default_meta

  private

  def set_default_meta
    page_meta.tag :dns_prefetch_control, "http://example.com"
    page_meta.tag :robots, "index, follow"
    page_meta.tag :copyright, "Example Inc."
  end
end
```

Finally, you can define meta tags for Facebook and Twitter:

```ruby
# Meta tags for Facebook
page_meta.tag :og, {
  image: helpers.asset_url("fb.png"),
  image_type: "image/png",
  image_width: 800,
  image_height: 600,
  description: @workshop.description,
  title: @workshop.name,
  url: workshop_url(@workshop)
}

# Meta tags for Twitter
page_meta.tag :twitter, {
  card: "summary_large_image",
  title: @workshop.name,
  description: @workshop.description,
  site: "@howto",
  creator: "@fnando",
  image: helpers.asset_url(@workshop.cover_image)
}
```

### Defining link tags

To define link tags, you have to use `PageMeta::Base#link` like the following:

```ruby
page_meta.link :canonical, href: article_url(article)
page_meta.link :last, href: article_url(articles.last)
page_meta.link :first, href: article_url(articles.first)
```

The hash can be any of the link tag's attributes. The following example defines the Safari 9 Pinned Tab icon:

```ruby
page_meta.link :mask_icon, color: "#4078c0", href: helpers.asset_url("mask_icon.svg")
```

### Rendering the elements

To render all tags, just do something like this:

```erb
<!DOCTYPE html>
<html lang="en">
  <head>
    <%= page_meta %>
  </head>
  <body>
    <%= yield %>
  </body>
</html>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fnando/page_meta. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
