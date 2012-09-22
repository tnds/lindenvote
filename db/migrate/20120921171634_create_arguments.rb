class CreateArguments < ActiveRecord::Migration
  def change
    create_table :arguments do |t|
      t.string :title
      t.text :description
      t.string :sort
      t.references :topic
      t.references :user

      t.timestamps
    end
    add_index :arguments, :topic_id
    add_index :arguments, :user_id
  end
end
