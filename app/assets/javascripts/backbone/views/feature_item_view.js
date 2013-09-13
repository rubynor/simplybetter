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

        render: function(){
            var self = this;
            this.$el.addClass('feature').html(_.template(self.template(),this.model.attributes));
            return this;
        }
    });

    return app;
}(SimplyBetterApplication.Features || {}));
