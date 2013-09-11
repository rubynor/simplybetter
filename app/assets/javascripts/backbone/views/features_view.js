var FeaturesCollectionView = Backbone.View.extend({
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
        this.$el.html(_.template(self.template()));

        //Render item views
        var ol = this.$el.find('ol');
        _.each(self.collection.models, function(model){
            var feature = new FeatureItemView({model: model});
            ol.append(feature.render().el);
        });
    }
});