SimplyBetterApplication.Notifications = (function (notifications) {
    var module = notifications;

    module.model = Backbone.Model.extend({
        url: function(){
          return SimplyBetterApplication.config.NotificationModelUrl(this.id);
        }
    });

    module.Collection = Backbone.Collection.extend({
        url: function(){
            return SimplyBetterApplication.config.NotificationCollectionUrl();
        },
        model: module.model
    });

    return module;
}(SimplyBetterApplication.Notifications || {}));

