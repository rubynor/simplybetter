var Feature = Backbone.Model.extend({
    url: function(){
        return '/features/' + this.id + '?token=JZTIJBHV';
    }
});

var Features = Backbone.Collection.extend({
    model: Feature,
    url: '/features?token=' + 'JZTIJBHV'
});

f = new Features;
f.fetch();


