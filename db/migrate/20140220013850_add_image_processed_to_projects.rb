class AddImageProcessedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :image_processed, :boolean
  end
end
