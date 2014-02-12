class RemoveVoterEmailFromVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :voter_email, :string
  end
end
