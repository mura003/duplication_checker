class <%= migration_class_name %> < ActiveRecord::Migration
  def change
    create_table :<%= duplication_table_name %> do |t|
      t.string :duplication_key, null: false
      t.timestamps
    end

    add_index :<%= duplication_table_name %>, :duplication_key, unique: true
  end
end
