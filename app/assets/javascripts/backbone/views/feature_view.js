
var FeatureView = Backbone.View.extend({
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

    render: function(){
        var self = this;
        return _.template(self.template(),this.model.attributes);
    }
});