var FeaturesView = Backbone.View.extend({
    template: function(){
        var tmp = "";
        $.ajax({
            url: 'http://localhost:3000/assets/backbone/templates/index.html',
            method: 'GET',
            async: false,
            success: function(response){
                tmp = response;
            }
        });
//        $.get("http://localhost:3000/assets/backbone/templates/index.html", function(response){
//            template = _.template(response);
//        }, {async: false});
//        console.log(template);
        return tmp;
    },
    el: '#features',

    render: function(){
        var self = this;
//        this.$el.html("<h1> hei </h1>" + this.template());
        this.$el.html(function(){
            var theList = [];
            _.each(self.collection.models, function(model){
                var item = new FeatureView({model: model});
                theList.push(item.render());
            });
            console.log(self.template());
            return _.template(self.template(),{features: theList});
        });
    }
});