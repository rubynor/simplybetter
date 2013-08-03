class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :feature_id
      t.string :voter_email
      t.integer :value

      t.timestamps
    end
  end
end
