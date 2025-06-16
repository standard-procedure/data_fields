class CreateDataFields < ActiveRecord::Migration[8.0]
  def change
    create_table :data_fields do |t|
      t.references :container, polymorphic: true, index: true
      t.references :parent, foreign_key: { to_table: :data_fields }, index: true
      t.integer :position
      t.integer :data_field_type, default: 0, null: false
      t.string  :type
      t.string  :name, null: false, default: ""
      t.json   :metadata
      t.json   :data
      t.timestamps
    end
  end
end
