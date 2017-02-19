class AddStyleRefToBeers < ActiveRecord::Migration
  def change
    add_reference :beers, :style, foreign_key: true
  end
end
