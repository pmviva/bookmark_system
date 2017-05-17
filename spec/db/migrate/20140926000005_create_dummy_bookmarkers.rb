###
# CreateDummyBookmarkers class
#
# This class defines the create dummy bookmarkers migration in bookmark system
###
class CreateDummyBookmarkers < ActiveRecord::Migration[5.0]
  ###
  # Changes the database
  ###
  def change
    ###
    # Dummy bookmarkers table creation
    ###
    create_table :dummy_bookmarkers do |t|
      ###
      # Timestamps fields definition
      ###
      t.timestamps null: false
    end
  end
end

