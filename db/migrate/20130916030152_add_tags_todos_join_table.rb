class AddTagsTodosJoinTable < ActiveRecord::Migration
  def up
    create_table :tags_todos, :id => false do |t|
      t.integer :tag_id
      t.integer :todo_id
    end
  end

  def down
    drop_table :tags_todos
  end
end
