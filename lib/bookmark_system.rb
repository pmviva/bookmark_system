require 'bookmark_system/bookmark'
require 'bookmark_system/bookmarkee'
require 'bookmark_system/bookmarker'

###
# BookmarkSystem module
#
# This module defines common behavior in bookmark system
###
module BookmarkSystem
  ###
  # Specifies if self can be bookmarked by {Bookmarker} objects
  #
  # @return [Boolean]
  ###
  def is_bookmarkee?
    false
  end

  ###
  # Specifies if self can bookmark {Bookmarkee} objects
  #
  # @return [Boolean]
  ###
  def is_bookmarker?
    false
  end

  ###
  # Instructs self to act as bookmarkee
  ###
  def act_as_bookmarkee
    include Bookmarkee
  end

  ###
  # Instructs self to act as bookmarker
  ###
  def act_as_bookmarker
    include Bookmarker
  end
end

ActiveRecord::Base.extend BookmarkSystem

