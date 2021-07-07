class CreateMovieNetworks < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_networks do |t|
      t.integer :movie_id
      t.integer :network_id

      t.timestamps
    end
  end
end
