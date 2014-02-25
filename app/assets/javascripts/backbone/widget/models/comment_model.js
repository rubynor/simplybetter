SimplyBetterApplication.Comments = (function (comments) {
    var module = comments;
    module.Model = Backbone.Model.extend({
        initialize: function(idea_id){
            this.set({idea_id: idea_id});
        },
        url: function(){
            if (this.isNew()){
                return SimplyBetterApplication.config.commentsNewModelUrl(this.get('idea_id'));
            } else {
                return SimplyBetterApplication.config.commentsModelUrl(this.get('idea_id'), this.id);
            }
        }
    });

    module.Collection = Backbone.Collection.extend({
        url: function(){
            //return SimplyBetterApplication.config.commentsCollectionUrl(this.options.idea_id);
        },
        model: module.Model
    });
    return module;
}(SimplyBetterApplication.Comments || {}));
