# BookmarkSystem

[![Build Status](https://travis-ci.org/pmviva/bookmark_system.png?gbranch=master)](https://travis-ci.org/pmviva/bookmark_system)
[![Gem Version](https://badge.fury.io/rb/bookmark_system.svg)](http://badge.fury.io/rb/bookmark_system)
[![Dependency Status](https://gemnasium.com/pmviva/bookmark_system.svg)](https://gemnasium.com/pmviva/bookmark_system)
[![Code Climate](https://codeclimate.com/github/pmviva/bookmark_system/badges/gpa.svg)](https://codeclimate.com/github/pmviva/bookmark_system)

An active record bookmark system developed using ruby on rails 4.1 applying domain driven design and test driven development principles.

This gem is heavily influenced by cmer/socialization.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bookmark_system'
```

And then execute:

```ruby
$ bundle
```

Or install it yourself as:

```ruby
$ gem install bookmark_system
```

## Usage

### Run the generator

```ruby
$ rails g bookmark_system
```

Let's suppose for a moment that you have a blog application and a User can bookmark a Post or several Post models.
The user model becomes the bookmarker and the post model becomes the bookmarkee.

### Post object
```ruby
class Post < ActiveRecord::Base
  act_as_bookmarkee

  validates :content, presence: true
end
```

### User object
```ruby
class User < ActiveRecord::Base
  act_as_bookmarker

  validates :username, { presence: true, uniqueness: true }
end
```

### Bookmarkee object methods
```ruby
post.is_bookmarkee? # returns true

post.bookmarked_by?(user) # returns true if user bookmarks the post object, false otherwise

post.bookmarkers_by(User) # returns a scope of BookmarkSystem::Bookmark join model that belongs to the post object and belongs to bookmarker objects of type User
```


### Bookmarker object methods
```ruby
user.is_bookmarker? # returns true

user.bookmark(post) # Creates an instance of BookmarkSystem::Bookmark join model associating the user object and the post object, returns true if succeded, false otherwise

user.unbookmark(post) # Destroys an instance of BookmarkSystem::Bookmark join model that associates the user object and the post object, returns true if succeded, false otherwise

user.toggle_bookmark(post) # Bookmarks / unbookmarks the post

user.bookmarks?(post) # returns true if the user object bookmarks the post object, false otherwise

user.bookmarkees_by(Post) # returns a scope of BookmarkSystem::Bookmark join model that belongs to the user object and belongs to bookmarkee objects of type Post
```

For more information read the [api documentation](http://rubydoc.info/gems/bookmark_system).

## Contributing

1. Fork it ( https://github.com/pmviva/bookmark_system/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

