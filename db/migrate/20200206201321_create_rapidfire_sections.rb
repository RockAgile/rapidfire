class CreateRapidfireSections < ActiveRecord::Migration[6.0]
  def change
    create_table :rapidfire_sections do |t|
      t.references :survey
      t.string :name
      t.text :description
      t.integer :position
      t.timestamps
    end

    change_table :rapidfire_questions do |t|
      t.references :section
    end
  end
end
