require 'spec_helper'

###
# Shared examples for BookmarkSystem::Bookmarkee
###
shared_examples_for BookmarkSystem::Bookmarkee do
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
    # Should have many bookmarkers
    ###
    it "should have many bookmarkers" do
      should have_many(:bookmarkers)
    end
  end

  ###
  # Describes class methods
  ###
  describe "class methods" do
    ###
    # Should be a bookmarkee
    ###
    it "should be a bookmarkee" do
      expect(bookmarkee.is_bookmarkee?).to equal(true)
    end

    ###
    # Should be bookmarked by a bookmarker
    ###
    it "should specify if is bookmarked by a bookmarker" do
      expect(BookmarkSystem::Bookmark).to receive(:bookmarks?).with(bookmarker, bookmarkee) { true }

      expect(bookmarkee.bookmarked_by?(bookmarker)).to equal(true)
    end

    ###
    # Should scope bookmarkers filtered by bookmarker type
    ###
    it "should scope bookmarkers filtered by bookmarker type" do
      scope = BookmarkSystem::Bookmark.scope_by_bookmarkee(bookmarkee).scope_by_bookmarker_type(DummyBookmarker)

      expect(bookmarkee.bookmarkers_by(DummyBookmarker)).to eq(scope)
    end
  end
end

###
# Describes DummyBookmarkee
###
describe DummyBookmarkee do
  ###
  # It behaves like BookmarkSystem::Bookmarkee
  ###
  it_behaves_like BookmarkSystem::Bookmarkee
end

