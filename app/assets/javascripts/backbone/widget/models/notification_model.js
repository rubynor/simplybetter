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
        model: module.model,
        comparator: function(noti){
          return -noti.get('id');
        }
    });

    return module;
}(SimplyBetterApplication.Notifications || {}));

