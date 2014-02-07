SimplyBetterApplication.Votes = (function(votes){
    var module = votes;

    module.IdeaView = Backbone.View.extend({
        initialize: function(){
            this.model.on('change', this.render, this);
        },
        className: 'vote-buttons',

        template: 'votes/vote_idea.html',

        events: {
            "click .up" : "vote_up",
            "click .down" : "vote_down"
        },

        saveModelOrError: function(){
            this.model.save(null,{
                success: function(){
                },
                error: function(model, response){
                    var jsonError = JSON.parse(response.response)["error"];
                    errorView = new SimplyBetterApplication.Alerts.ErrorView({message: jsonError});
                    errorView.render();
                }
            });
        },

        vote_up: function(){
            this.model.set({value: 2});
            this.saveModelOrError();
        },

        vote_down: function(){
            this.model.set({value: -2});
            this.saveModelOrError();
        },

        voteStatusClass: function(){
            var vote = this.model.get('value');
            var result = {
                up: '',
                down: ''
            };
            if (vote === 1){
                result.up = 'active';
            } else if (vote === -1){
                result.down = 'active';
            }
            return result;
        },

        render: function(){
            var template = SimplyBetterApplication.Template.get(this.template);
            this.$el.html(template({
                vote: this.model.attributes, 
                voteClass: this.voteStatusClass()
            }));
            return this;
        }
    });

    return module;
}(SimplyBetterApplication.Votes || {}));
