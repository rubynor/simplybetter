SimplyBetterApplication.Features = (function(features){
    var app = features;

    app.BaseItemView = Backbone.View.extend({
        initialize: function(){
            this.listenTo(this.options.navigator, 'close', this.close);
            this.voteStatus = this.options.voteStatus || new app.VoteStatusModel({feature_id: this.model.get('id'), email: SimplyBetterApplication.config.userEmail, value: 0});
        },
        
        className: 'feature',
        events: {
            "click .up" : "vote_up",
            "click .down" : "vote_down"
        },
        vote: function(upOrDown){
            var self = this;
            var id = this.model.get('id');
            $.ajax({
                type: 'POST',
                url: SimplyBetterApplication.config.featuresCastVoteRoot() + upOrDown,
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
                    errorMessageView = new SimplyBetterApplication.UiFeedback.ErrorView({errorMessage: "You need to be signed in to vote!"});
                    errorMessageView.render();
                }
            });
        },
        vote_up: function(){
            //
            //  Check trello: voteStatus should be controlled
            //  by backbone.js. Using model.save etc..
            //  By changing to this pattern we will not have
            //  to use the .vote() funciton with ajax calls etc..
            this.vote('up');
            if (this.voteStatus.get('value') < 1){
                this.voteStatus.set({value: 1});
            } else {
                this.voteStatus.set({value: 0});
            }
        },
        vote_down: function(){
            this.vote('down');
            if (this.voteStatus.get('value') > -1){
                this.voteStatus.set({value: -1});
            } else {
                this.voteStatus.set({value: 0});
            }
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
            this.voteStatus.fetch({
                success: function(response){
                    self.$el.html(_.template(self.template(),{feature: self.model.attributes, voteClass: self.voteStatusClass(response), helpers: self}));
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
            var feature = new SimplyBetterApplication.Features.showFeature({model: this.model, navigator: this.options.navigator, voteStatus: this.voteStatus});
            this.options.navigator.trigger('close');
            //var feature_layout = new SimplyBetterApplication.Features.Layout({feature: this.model, navigator: this.options.navigator});
            this.options.navigator.$el.find('#featureVotingFeaturesModalContent').html(feature.render().el);
        }
    });

    return app;
}(SimplyBetterApplication.Features || {}));
