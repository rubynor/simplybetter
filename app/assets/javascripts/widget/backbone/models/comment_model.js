SimplyBetterApplication.Comments = (function (comments) {
    var module = comments;
    module.Model = Backbone.Model.extend({
        initialize: function(feature_id){
            this.set({feature_id: feature_id});
        },
        url: function(){
            if (this.isNew()){
                return SimplyBetterApplication.config.commentsNewModelUrl(this.get('feature_id'));
            } else {
                return SimplyBetterApplication.config.commentsModelUrl(this.get('feature_id'), this.id);
            }
        }
    });

    module.Collection = Backbone.Collection.extend({
        url: function(){
            //return SimplyBetterApplication.config.commentsCollectionUrl(this.options.feature_id);
        },
        model: module.Model
    });
    return module;
}(SimplyBetterApplication.Comments || {}));
