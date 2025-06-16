class CreateMyContainers < ActiveRecord::Migration[8.0]
  def change
    create_table :my_containers do |t|
      t.string :name

      t.timestamps
    end
  end
end
