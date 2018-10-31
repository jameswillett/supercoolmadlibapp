class CreateSolutions < ActiveRecord::Migration[5.1]
  def change
    create_table :solutions do |t|
      t.references :mad_lib, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
