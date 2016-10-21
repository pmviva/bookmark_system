require 'spec_helper'

###
# Describes BookmarkSystem::Bookmark
###
describe BookmarkSystem::Bookmark, type: :model do
  ###
  # Let bookmarkee be DummyBookmarkee.create
  ###
  let(:bookmarkee) { DummyBookmarkee.create }

  ###
  # Let bookmarker be DummyBookmarker.create
  ###
  let(:bookmarker) { DummyBookmarker.create }

  ###
  # Describes associations
  ###
  describe "associations" do
    ###
    # Should belong to bookmarkee
    ###
    it "should belong to bookmarkee" do
      should belong_to(:bookmarkee)
    end

    ###
    # Should belong to bookmarker
    ###
    it "should belong to bookmarker" do
      should belong_to(:bookmarker)
    end
  end

  ###
  # Describes class methods
  ###
  describe "class methods" do
    ###
    # Should raise argument error on invalid bookmarkee when bookmarks
    ###
    it "should raise argument error on invalid bookmarkee when bookmarks" do
      expect { BookmarkSystem::Bookmark.bookmark(bookmarker, bookmarker) }.to raise_error ArgumentError
    end

    ###
    # Should raise argument error on invalid bookmarker when bookmarks
    ###
    it "should raise argument error on invalid bookmarker when bookmarks " do
      expect { BookmarkSystem::Bookmark.bookmark(bookmarkee, bookmarkee) }.to raise_error ArgumentError
    end

    ###
    # Should bookmark
    ###
    it "should bookmark" do
      expect(BookmarkSystem::Bookmark.bookmark(bookmarker, bookmarkee)).to equal(true)
    end

    ###
    # Should not bookmark
    ###
    it "should not bookmark" do
      BookmarkSystem::Bookmark.bookmark(bookmarker, bookmarkee)

      expect(BookmarkSystem::Bookmark.bookmark(bookmarker, bookmarkee)).to equal(false)
    end

    ###
    # Should raise argument error on invalid bookmarkee when unbookmarks
    ###
    it "should raise argument error on invalid bookmarkee when unbookmarks" do
      expect { BookmarkSystem::Bookmark.unbookmark(bookmarker, bookmarker) }.to raise_error ArgumentError
    end

    ###
    # Should raise argument error on invalid bookmarker when unbookmarks
    ###
    it "should raise argument error on invalid bookmarker when unbookmarks" do
      expect { BookmarkSystem::Bookmark.unbookmark(bookmarkee, bookmarkee) }.to raise_error ArgumentError
    end

    ###
    # Should unbookmark
    ###
    it "should unbookmark" do
      BookmarkSystem::Bookmark.bookmark(bookmarker, bookmarkee)

      expect(BookmarkSystem::Bookmark.unbookmark(bookmarker, bookmarkee)).to equal(true)
    end

    ###
    # Should not unbookmark
    ###
    it "should not unbookmark" do
      expect(BookmarkSystem::Bookmark.unbookmark(bookmarker, bookmarkee)).to equal(false)
    end

    ###
    # Should raise argument error on invalid bookmarkee when toggle bookmark
    ###
    it "should raise argument error on invalid bookmarkee when toggle bookmark" do
      expect { BookmarkSystem::Bookmark.toggle_bookmark(bookmarker, bookmarker) }.to raise_error ArgumentError
    end

    ###
    # Should raise argument error on invalid bookmarker when toggle bookmark
    ###
    it "should raise argument error on invalid bookmarker when toggle bookmark" do
      expect { BookmarkSystem::Bookmark.toggle_bookmark(bookmarkee, bookmarkee) }.to raise_error ArgumentError
    end

    ###
    # Should toggle bookmark
    ###
    it "should toggle bookmark" do
      expect(BookmarkSystem::Bookmark.bookmarks?(bookmarker, bookmarkee)).to equal(false)

      BookmarkSystem::Bookmark.toggle_bookmark(bookmarker, bookmarkee)

      expect(BookmarkSystem::Bookmark.bookmarks?(bookmarker, bookmarkee)).to equal(true)

      BookmarkSystem::Bookmark.toggle_bookmark(bookmarker, bookmarkee)

      expect(BookmarkSystem::Bookmark.bookmarks?(bookmarker, bookmarkee)).to equal(false)
    end

    ###
    # Should specify if bookmarks
    ###
    it "should specify if bookmarks" do
      expect(BookmarkSystem::Bookmark.bookmarks?(bookmarker, bookmarkee)).to equal(false)

      BookmarkSystem::Bookmark.bookmark(bookmarker, bookmarkee)

      expect(BookmarkSystem::Bookmark.bookmarks?(bookmarker, bookmarkee)).to equal(true)
    end

    ###
    # Should scope bookmarks by bookmarkee
    ###
    it "should scope bookmarks by bookmarkee" do
      scope = BookmarkSystem::Bookmark.where(bookmarkee: bookmarkee)

      expect(BookmarkSystem::Bookmark.scope_by_bookmarkee(bookmarkee)).to eq(scope)
    end

    ###
    # Should scope bookmarks by bookmarkee type
    ####
    it "should scope bookmarks by bookmarkee type" do
      scope = BookmarkSystem::Bookmark.where(bookmarkee_type: "DummyBookmarkee")

      expect(BookmarkSystem::Bookmark.scope_by_bookmarkee_type("DummyBookmarkee")).to eq(scope)
    end

    ###
    # Should scope bookmarks by bookmarker
    ###
    it "should scope bookmarks by bookmarker" do
      scope = BookmarkSystem::Bookmark.where(bookmarker: bookmarker)

      expect(BookmarkSystem::Bookmark.scope_by_bookmarker(bookmarker)).to eq(scope)
    end

    ###
    # Should scope bookmarks by bookmarker type
    ####
    it "should scope bookmarks by bookmarker type" do
      scope = BookmarkSystem::Bookmark.where(bookmarker_type: "DummyBookmarker")

      expect(BookmarkSystem::Bookmark.scope_by_bookmarker_type("DummyBookmarker")).to eq(scope)
    end
  end
end

