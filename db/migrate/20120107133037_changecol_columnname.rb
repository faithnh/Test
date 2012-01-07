class ChangecolColumnname < ActiveRecord::Migration
  def up
    rename_column :categories, :type, :type_name
  end

  def down
    rename_column :categories, :type_name, :type
  end
end
