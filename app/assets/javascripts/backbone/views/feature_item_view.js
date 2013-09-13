SimplyBetterApplication.Features = (function(features){
    app = features;

    app.itemView = Backbone.View.extend({
        template: function(){
            var tmp = "";
            $.ajax({
                url: SimplyBetterApplication.config.baseUrl + '/assets/backbone/templates/feature_item.html',
                method: 'GET',
                async: false,
                success: function(response){
                    tmp = response;
                }
            });
            return tmp;
        },
        tagName: 'li',
        events: {
            "click .up" : "vote_up",
            "click .down" : "vote_down",
            "click h1" : "showFeature"
        },

        vote: function(upOrDown){
            var self = this;
            var id = this.model.get('id');
            $.ajax({
                type: 'POST',
                url: SimplyBetterApplication.config.baseUrl + '/vote_'+upOrDown,
                data: {
                    token: window.appKey,
                    voter_email: window.userEmail,
                    voter_name: window.userName,
                    feature_id: id
                },
                success: function(response){
                    self.model.fetch({
                        success: function(){
                            self.render();
                        }
                    });
                }
            });
        },
        vote_up: function(){
            this.vote('up');
        },
        vote_down: function(){
            this.vote('down');
        },

        showFeature: function(){
            var feature = new SimplyBetterApplication.Features.show({model: this.model});
            feature.render();
        },
        voteStatusClass: function(voteStatus){
            var voteStatusValue = voteStatus.get('value');
            var result = {
                up: '',
                down: ''
            };
            if (voteStatusValue === 1){
                result.up = 'active';
            } else if (voteStatusValue === -1){
                result.down = 'active';
            }
            return result;
        },

        render: function(){
            self = this;
            var voteStatus = new app.VoteStatusModel({feature_id: this.model.get('id'), email: SimplyBetterApplication.config.userEmail});
            voteStatus.fetch({
                success: function(response){
                    self.$el.addClass('feature').html(_.template(self.template(),{feature: self.model.attributes, voteClass: self.voteStatusClass(response)}));
                },
                async: false
            });
            return this;
        }
    });

    return app;
}(SimplyBetterApplication.Features || {}));
