SimplyBetterApplication.Votes = (function(votes){
    var module = votes;

    module.FeatureView = Backbone.View.extend({
        initialize: function(){
            this.model.on('change', this.render, this);
        },
        className: 'vote-buttons',

        template: 'votes/vote_feature.html',

        events: {
            "click .up" : "vote_up",
            "click .down" : "vote_down"
        },

        vote_up: function(){
            this.model.set({value: 2});
            this.model.save();
        },

        vote_down: function(){
            this.model.set({value: -2});
            this.model.save();
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
