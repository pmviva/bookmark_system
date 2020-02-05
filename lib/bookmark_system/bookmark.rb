###
# BookmarkSystem module
#
# This module defines common behavior in bookmark system
###
module BookmarkSystem
  ###
  # Bookmark class
  #
  # This class defines the bookmark model in bookmark system
  ###
  class Bookmark < ActiveRecord::Base
    ###
    # Belongs to bookmarkee association configuration
    ###
    belongs_to :bookmarkee, polymorphic: :true

    ###
    # Belongs to bookmarker association configuration
    ###
    belongs_to :bookmarker, polymorphic: :true

    ###
    # Creates a {Bookmark} relationship between a {Bookmarker} object and a {Bookmarkee} object
    #
    # @param [Bookmarker] bookmarker - the {Bookmarker} of the relationship
    # @param [Bookmarkee] bookmarkee - the {Bookmarkee} of the relationship
    # @return [Boolean]
    ###
    def self.bookmark(bookmarker, bookmarkee)
      validate_bookmarkee(bookmarkee)
      validate_bookmarker(bookmarker)

      if bookmarks?(bookmarker, bookmarkee)
        false
      else
        bookmark = scope_by_bookmarker(bookmarker).scope_by_bookmarkee(bookmarkee).build
        bookmark.save
        true
      end
    end

    ###
    # Destroys a {Bookmark} relationship between a {Bookmarker} object and a {Bookmarkee} object
    #
    # @param [Bookmarker] bookmarker - the {Bookmarker} of the relationship
    # @param [Bookmarkee] bookmarkee - the {Bookmarkee} of the relationship
    # @return [Boolean]
    ###
    def self.unbookmark(bookmarker, bookmarkee)
      validate_bookmarkee(bookmarkee)
      validate_bookmarker(bookmarker)

      if bookmarks?(bookmarker, bookmarkee)
        bookmark = scope_by_bookmarker(bookmarker).scope_by_bookmarkee(bookmarkee).take
        bookmark.destroy
        true
      else
        false
      end
    end

    ###
    # Toggles a {Bookmark} relationship between a {Bookmarker} object and a {Bookmarkee} object
    #
    # @param [Bookmarker] bookmarker - the {Bookmarker} of the relationship
    # @param [Bookmarkee] bookmarkee - the {Bookmarkee} of the relationship
    # @return [Boolean]
    ###
    def self.toggle_bookmark(bookmarker, bookmarkee)
      validate_bookmarkee(bookmarkee)
      validate_bookmarker(bookmarker)

      if bookmarks?(bookmarker, bookmarkee)
        unbookmark(bookmarker, bookmarkee)
      else
        bookmark(bookmarker, bookmarkee)
      end
    end

    ###
    # Specifies if a {Bookmarker} object bookmarks a {Bookmarkee} object
    #
    # @param [Bookmarker] bookmarker - the {Bookmarker} object to test against
    # @param [Bookmarkee] bookmarkee - the {Bookmarkee} object to test against
    # @return [Boolean]
    ###
    def self.bookmarks?(bookmarker, bookmarkee)
      validate_bookmarkee(bookmarkee)
      validate_bookmarker(bookmarker)

      scope_by_bookmarker(bookmarker).scope_by_bookmarkee(bookmarkee).exists?
    end

    ###
    # Retrieves a scope of {Bookmark} objects filtered by a {Bookmarkee} object
    #
    # @param [Bookmarkee] bookmarkee - the {Bookmarkee} to filter
    # @return [ActiveRecord::Relation]
    ###
    def self.scope_by_bookmarkee(bookmarkee)
      where(bookmarkee: bookmarkee)
    end

    ###
    # Retrieves a scope of {Bookmark} objects filtered by a {Bookmarkee} type
    #
    # @param [Class] klass - the {Class} to filter
    # @return [ActiveRecord::Relation]
    ###
    def self.scope_by_bookmarkee_type(klass)
      where(bookmarkee_type: klass.to_s.classify)
    end

    ###
    # Retrieves a scope of {Bookmark} objects filtered by a {Bookmarker} object
    #
    # @param [Bookmarker] bookmarker - the {Bookmarker} to filter
    # @return [ActiveRecord::Relation]
    ###
    def self.scope_by_bookmarker(bookmarker)
      where(bookmarker: bookmarker)
    end

    ###
    # Retrieves a scope of {Bookmark} objects filtered by a {Bookmarker} type
    #
    # @param [Class] klass - the {Class} to filter
    # @return [ActiveRecord::Relation]
    ###
    def self.scope_by_bookmarker_type(klass)
      where(bookmarker_type: klass.to_s.classify)
    end

    private
      ###
      # Validates a bookmarkee object
      #
      # @raise [ArgumentError] if the bookmarkee object is invalid
      ###
      def self.validate_bookmarkee(bookmarkee)
        raise ArgumentError.new unless bookmarkee.respond_to?(:is_bookmarkee?) && bookmarkee.is_bookmarkee?
      end

      ###
      # Validates a bookmarker object
      #
      # @raise [ArgumentError] if the bookmarker object is invalid
      ###
      def self.validate_bookmarker(bookmarker)
        raise ArgumentError.new unless bookmarker.respond_to?(:is_bookmarker?) && bookmarker.is_bookmarker?
      end
  end
end
