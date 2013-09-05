class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :todo
      t.boolean :done

      t.timestamps
    end
  end
end
