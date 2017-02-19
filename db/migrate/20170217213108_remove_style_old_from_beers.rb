class RemoveStyleOldFromBeers < ActiveRecord::Migration
  def change
    remove_column :beers, :style_old, :integer
  end
end
