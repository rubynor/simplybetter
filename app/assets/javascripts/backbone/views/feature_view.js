
var FeatureView = Backbone.View.extend({
    tagName: 'li',

    render: function(){
        return "<li>"+this.model.get('title')+"</li>";
    }
});