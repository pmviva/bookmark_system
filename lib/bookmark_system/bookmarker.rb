###
# BookmarkSystem module
#
# This module defines common behavior in bookmark system
###
module BookmarkSystem
  ###
  # Bookmarker module
  #
  # This module defines bookmarker behavior in bookmark system
  ###
  module Bookmarker
    ###
    # Extends ActiveSupport::Concern
    ###
    extend ActiveSupport::Concern

    ###
    # Included configuration
    ###
    included do
      ###
      # Has many bookmarkees association configuration
      ###
      has_many :bookmarkees, class_name: "BookmarkSystem::Bookmark", as: :bookmarker, dependent: :destroy
    end

    ###
    # Specifies if self can bookmark {Bookmarkee} objects
    #
    # @return [Boolean]
    ###
    def is_bookmarker?
      true
    end

    ###
    # Creates a {Bookmark} relationship between self and a {Bookmarkee} object
    #
    # @param [Bookmarkee] bookmarkee - the bookmarkee of the {Bookmark} relationship
    # @return [Boolean]
    ###
    def bookmark(bookmarkee)
      Bookmark.bookmark(self, bookmarkee)
    end

    ###
    # Destroys a {Bookmark} relationship between self and a {Bookmarkee} object
    #
    # @param [Bookmarkee] bookmarkee - the bookmarkee of the {Bookmark} relationship
    # @return [Boolean]
    ###
    def unbookmark(bookmarkee)
      Bookmark.unbookmark(self, bookmarkee)
    end

    ###
    # Toggles a {Bookmark} relationship between self and a {Bookmarkee} object
    #
    # @param [Bookmarkee] bookmarkee - the bookmarkee of the {Bookmark} relationship
    # @return [Boolean]
    ###
    def toggle_bookmark(bookmarkee)
      Bookmark.toggle_bookmark(self, bookmarkee)
    end

    ###
    # Specifies if self bookmarks a {Bookmarker} object
    #
    # @param [Bookmarkee] bookmarkee - the {Bookmarkee} object to test against
    # @return [Boolean]
    ###
    def bookmarks?(bookmarkee)
      Bookmark.bookmarks?(self, bookmarkee)
    end

    ###
    # Retrieves a scope of {Bookmark} objects that are bookmarked by self
    #
    # @param [Class] klass - the {Class} to include
    # @return [ActiveRecord::Relation]
    ###
    def bookmarkees_by(klass)
      Bookmark.scope_by_bookmarker(self).scope_by_bookmarkee_type(klass)
    end
  end
end

