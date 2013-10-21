SimplyBetterApplication.Comments = (function (comments) {
    module = comments;
    module.Model = Backbone.Model.extend({
        initialize: function(feature_id){
            this.feature_id = feature_id;
        },
        url: function(){
            if (this.isNew()){
                return SimplyBetterApplication.config.commentsNewModelUrl(this.feature_id);
            } else {
                return SimplyBetterApplication.config.commentsModelUrl(this.feature_id, this.id);
            }
        }
    });

    module.Collection = Backbone.Collection.extend({
        initialize: function(feature_id){
            this.feature_id = feature_id;
        },
        url: function(){
          console.log(this);
            return SimplyBetterApplication.config.commentsCollectionUrl(this.feature_id);
        },
        model: module.Model
    });
    return module;
}(SimplyBetterApplication.Comments || {}));
