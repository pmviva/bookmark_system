###
# CreateBookmarks class
#
# This class defines the create bookmarks migration in bookmark system
###
class CreateBookmarks < ActiveRecord::Migration[5.0]
  ###
  # Changes the database
  ###
  def change
    ###
    # Bookmarks table creation
    ###
    create_table :bookmarks do |t|
      ###
      # Bookmarkee id field and bookmarkee type field definition
      ###
      t.references :bookmarkee, polymorphic: true

      ###
      # Bookmarker id fiel and bookmarker type field definition
      ###
      t.references :bookmarker, polymorphic: true

      ###
      # Timestamps fields definition
      ###
      t.timestamps null: false
    end

    ###
    # Bookmarks table bookmarkee id field and bookmarkee type field index addition
    ###
    add_index :bookmarks, [:bookmarkee_id, :bookmarkee_type], name: "bookmarks_bookmarkee_idx"

    ###
    # Bookmarks table bookmarker id field and bookmarker type field index addition
    ###
    add_index :bookmarks, [:bookmarker_id, :bookmarker_type], name: "bookmarks_bookmarker_idx"

    ###
    # Bookmarks table bookmarkee id field and bookmarkee type field and bookmarker id field and bookmarker type field unique index addition
    ###
    add_index :bookmarks, [:bookmarkee_id, :bookmarkee_type, :bookmarker_id, :bookmarker_type], name: "bookmarks_bookmarkee_bookmarker_idx", unique: true
  end
end
