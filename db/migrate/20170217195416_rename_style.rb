class RenameStyle < ActiveRecord::Migration
  def change
    rename_table :styles, :styles21
  end
end
