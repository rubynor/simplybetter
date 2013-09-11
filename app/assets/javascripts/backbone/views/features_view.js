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
        return tmp;
    },
    el: '#features',

    render: function (){
        var self = this;
        var theList = [];
        this.$el.html(function(){
            _.each(self.collection.models, function(model){
                var item = new FeatureView({model: model});
                theList.push(item);
            });
            return _.template(self.template(),{list: theList,features: function(theList){
                _.each(theList, function(feature){
                    feature.render();
                });
            }});
        });
    }
});