class AddCoverImageUrlToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :cover_image_url, :string
  end
end