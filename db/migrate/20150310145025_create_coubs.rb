class CreateCoubs < ActiveRecord::Migration
  def change
    create_table :coubs do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.string :visibility_type
      t.string :tags
      t.string :permalink
      t.string :coub_id
      t.string :text1
      t.string :text2
      t.string :text3

      t.timestamps
    end
  end
end
