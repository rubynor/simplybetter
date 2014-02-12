class AddVoterToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :voter_type, :string
    add_column :votes, :voter_id, :integer
  end
end
