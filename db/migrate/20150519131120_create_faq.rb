class CreateFaq < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.integer :application_id
      t.text :question
      t.text :answer
      t.timestamps
    end
    add_index :faqs, [:application_id, :question], unique: true, order: {application_id: :asc, question: :asc}
  end
end
