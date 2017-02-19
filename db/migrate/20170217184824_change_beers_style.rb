class ChangeBeersStyle < ActiveRecord::Migration
  def change
    rename_column :beers, :style, :style_old
  end
end
