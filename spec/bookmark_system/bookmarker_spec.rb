require 'spec_helper'

###
# Shared examples for BookmarkSystem::Bookmarker
###
shared_examples_for BookmarkSystem::Bookmarker do
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
    # Should have many bookmarkees
    ###
    it "should have many bookmarkees" do
      should have_many(:bookmarkees)
    end
  end

  ###
  # Describes class methods
  ###
  describe "class methods" do
    ###
    # Should be a bookmarker
    ###
    it "should be a bookmarker" do
      expect(bookmarker.is_bookmarker?).to equal(true)
    end

    ###
    # Should bookmark a bookmarkee
    ###
    it "Should bookmark a bookmarkee" do
      expect(BookmarkSystem::Bookmark).to receive(:bookmark).with(bookmarker, bookmarkee) { true }

      expect(bookmarker.bookmark(bookmarkee)).to equal(true)
    end

    ###
    # Should unbookmark a bookmarkee
    ###
    it "Should unbookmark a bookmarkee" do
      expect(BookmarkSystem::Bookmark).to receive(:unbookmark).with(bookmarker, bookmarkee) { true }

      expect(bookmarker.unbookmark(bookmarkee)).to equal(true)
    end

    ###
    # Should toggle bookmark a bookmarkee
    ###
    it "Should toggle bookmark a bookmarkee" do
      expect(BookmarkSystem::Bookmark).to receive(:toggle_bookmark).with(bookmarker, bookmarkee) { true }

      expect(bookmarker.toggle_bookmark(bookmarkee)).to equal(true)
    end

    ###
    # Should bookmark a bookmarkee
    ###
    it "should specify if bookmarks a bookmarkee" do
      expect(BookmarkSystem::Bookmark).to receive(:bookmarks?).with(bookmarker, bookmarkee) { true }

      expect(bookmarker.bookmarks?(bookmarkee)).to equal(true)
    end

    ###
    # Should scope bookmarkees filtered by bookmarkee type
    ###
    it "should scope bookmarkees filtered by bookmarkee type" do
      scope = BookmarkSystem::Bookmark.scope_by_bookmarker(bookmarker).scope_by_bookmarkee_type(DummyBookmarkee)

      expect(bookmarker.bookmarkees_by(DummyBookmarkee)).to eq(scope)      
    end
  end
end

###
# Describes DummyBookmarker
###
describe DummyBookmarker, type: :model do
  ###
  # It behaves like BookmarkSystem::Bookmarker
  ###
  it_behaves_like BookmarkSystem::Bookmarker
end

