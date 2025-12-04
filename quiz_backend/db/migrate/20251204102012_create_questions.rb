class CreateQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :questions do |t|
      t.references :quiz, null: false, foreign_key: true
      t.string :kind
      t.text :prompt
      t.jsonb :options
      t.jsonb :correct

      t.timestamps
    end
  end
end
