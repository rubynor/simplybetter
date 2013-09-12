
var FeatureItemView = Backbone.View.extend({
    template: function(){
        var tmp = "";
        $.ajax({
            url: 'http://localhost:3000/assets/backbone/templates/feature.html',
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
        "click .down" : "vote_down"
    },

    vote: function(upOrDown,element){
        var self = this;
        var id = this.model.get('id');
        var element = $(element.target).closest('li');
        $.ajax({
            type: 'POST',
            url: 'http://localhost:3000/vote_'+upOrDown,
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
    vote_up: function(e){
        console.log("You triggered vote_up!");
        console.log("I am "+ this.model.get('id'));
        this.vote('up',e);
    },
    vote_down: function(e){
        console.log("You triggered vote_down!");
        console.log("I am "+ this.model.get('id'));
        this.vote('down',e);
    },

    render: function(){
        var self = this;
        this.$el.addClass('feature').html(_.template(self.template(),this.model.attributes));
        return this;
    }
});