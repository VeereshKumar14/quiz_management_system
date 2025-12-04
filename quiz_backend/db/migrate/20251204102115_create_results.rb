class CreateResults < ActiveRecord::Migration[8.1]
  def change
    create_table :results do |t|
      t.references :quiz, null: false, foreign_key: true
      t.jsonb :answers
      t.float :score

      t.timestamps
    end
  end
end
