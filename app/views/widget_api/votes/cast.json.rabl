object @vote

attributes :voter_email, :value, :vote_receiver_id

glue(@vote_receiver) {attribute :votes_count}
