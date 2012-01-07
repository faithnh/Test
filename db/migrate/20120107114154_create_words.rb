class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.text :problem
      t.text :answer
      t.references :user
      t.references :category
      t.timestamps
    end
  end
end
