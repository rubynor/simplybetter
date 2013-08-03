class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :vote_receiver_id
      t.string :vote_receiver_type
      t.string :voter_email
      t.integer :value

      t.timestamps
    end
  end
end
