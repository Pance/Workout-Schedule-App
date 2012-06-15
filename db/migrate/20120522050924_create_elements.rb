class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.integer :schedule_id

      t.timestamps
    end
  end
end
