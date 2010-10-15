class AddScore < ActiveRecord::Migration
  def self.up
    add_column :movies, :score, :integer, :default => 0
  end

  def self.down
    remove_column :movies, :score
  end
end
