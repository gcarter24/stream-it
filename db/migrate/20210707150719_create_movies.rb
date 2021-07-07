class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.integer :watchmode_id
      t.string :title
      t.text :plot
      t.string :media_type
      t.integer :runtime_minutes
      t.integer :year
      t.decimal :user_rating, precision: 3, scale: 2
      t.string :rating
      t.string :language
      t.string :image
      t.string :streaming_url

      t.timestamps
    end
  end
end
