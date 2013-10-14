SimplyBetterApplication.Features = (function(features){
    app = features;

    app.BaseItemView = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
        },
        events: {
            "click .up" : "vote_up",
            "click .down" : "vote_down"
        },
        vote: function(upOrDown){
            var self = this;
            var id = this.model.get('id');
            $.ajax({
                type: 'POST',
                url: SimplyBetterApplication.config.featuresCastVoteRoot + upOrDown,
                data: {
                    token: SimplyBetterApplication.config.appKey,
                    voter_email: SimplyBetterApplication.config.userEmail,
                    voter_name: SimplyBetterApplication.config.userName,
                    feature_id: id
                },
                success: function(){
                    self.model.fetch({
                        success: function(){
                            self.render();
                        }
                    });
                },
                error: function(e, textStatus, error){
                    console.log('Error');
                    console.log(e);
                    console.log(textStatus);
                    console.log(error);
                }
            });
        },
        vote_up: function(){
            this.vote('up');
        },
        vote_down: function(){
            this.vote('down');
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

        close: function(){
            this.remove();
        },

        truncate: function(string, length){
            var returnValue = string.substring(0,length);
            if (string.length > length){
                returnValue += '...'
            }
            return returnValue;
        },


        render: function(){
            self = this;
            var voteStatus = new app.VoteStatusModel({feature_id: this.model.get('id'), email: SimplyBetterApplication.config.userEmail});
            voteStatus.fetch({
                success: function(response){
                    self.$el.addClass('feature').html(_.template(self.template(),{feature: self.model.attributes, voteClass: self.voteStatusClass(response), helpers: self}));
                },
                async: false
            });
            return this;
        }
    });




    app.itemView = app.BaseItemView.extend({
        template: function(){
            var tmp = "";
            $.ajax({
                url: SimplyBetterApplication.config.templateUrl + 'feature_item.html',
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

        showFeature: function(){
            var feature = new SimplyBetterApplication.Features.showFeature({model: this.model, navigator: this.options.navigator});
            this.options.navigator.trigger('close');
            this.options.navigator.$el.find('#featureVotingFeaturesModalContent').html(feature.render().el);
        }
    });

    return app;
}(SimplyBetterApplication.Features || {}));
