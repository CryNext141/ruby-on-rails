class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title, null: false, default: '', index: true
      t.text :description, default: ''
      t.string :duration
      t.string :director
      t.integer :year_of_creation, default: 1900
      t.text :genre, array: true, default: []

      t.timestamps
    end
  end
end
