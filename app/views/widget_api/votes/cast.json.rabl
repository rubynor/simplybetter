object @vote

attributes :value, :vote_receiver_id

glue(@vote_receiver) {attribute :votes_count}
glue(@voter) {attribute :email}
