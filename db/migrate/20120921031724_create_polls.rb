class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.references :topic

      t.timestamps
    end
    add_index :polls, :topic_id
  end
end
