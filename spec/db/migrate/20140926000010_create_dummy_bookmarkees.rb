###
# CreateDummyBookmarkees class
#
# This class defines the create dummy bookmarkees migration in bookmark system
###
class CreateDummyBookmarkees < ActiveRecord::Migration[5.0]
  ###
  # Changes the database
  ###
  def change
    ###
    # Dummy bookmarkees table creation
    ###
    create_table :dummy_bookmarkees do |t|
      ###
      # Timestamps fields definition
      ###
      t.timestamps null: false
    end
  end
end
