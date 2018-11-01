class AddWordsToSolution < ActiveRecord::Migration[5.1]
  def change
    add_column :solutions, :words, :text
  end
end
