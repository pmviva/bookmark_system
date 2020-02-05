###
# BookmarkSystem module
#
# This module defines common behavior in bookmark system
###
module BookmarkSystem
  ###
  # Bookmarkee module
  #
  # This module defines bookmarkee behavior in bookmark system
  ###
  module Bookmarkee
    ###
    # Extends ActiveSupport::Concern
    ###
    extend ActiveSupport::Concern

    ###
    # Included configuration
    ###
    included do
      ###
      # Has many bookmarkers association configuration
      ###
      has_many :bookmarkers, class_name: "BookmarkSystem::Bookmark", as: :bookmarkee, dependent: :destroy
    end

    ###
    # Specifies if self can be bookmarked by {Bookmarker} objects
    #
    # @return [Boolean]
    ###
    def is_bookmarkee?
      true
    end

    ###
    # Specifies if self is bookmarked by a {Bookmarker} object
    #
    # @param [Bookmarker] bookmarker - the {Bookmarker} object to test against
    # @return [Boolean]
    ###
    def bookmarked_by?(bookmarker)
      Bookmark.bookmarks?(bookmarker, self)
    end

    ###
    # Retrieves a scope of {Bookmark} objects that bookmarks self filtered {Bookmarker} type
    #
    # @param [Class] klass - the {Class} to filter
    # @return [ActiveRecord::Relation]
    ###
    def bookmarkers_by(klass)
      Bookmark.scope_by_bookmarkee(self).scope_by_bookmarker_type(klass)
    end
  end
end
