/** @jsx React.DOM */
SimplyBetterApplication.Views = (function(views){
  var module = views;

  module.Notifications = React.createClass({
    componentWillMount: function(){
      this.callback = (function() {
        this.forceUpdate();
      }).bind(this);

      this.props.collection.on("all", this.callback);
    },
    componentWillUnmount: function(){
      this.props.collection.off("all", this.callback);
    },
    getInitialState: function(){
      return {show: false};
    },
    active: function(name){
      if (name == this.props.router.current)
        return 'active';
    },
    newNotifications: function(){
      var collection = this.props.collection;
      var newCount = 0;
      collection.models.map(function(model){
        if (!model.get('checked'))
          newCount ++;
      });

      return newCount;
    },
    showNotificationClass: function(){
      if (this.newNotifications() > 0)
        return 'new-notifications';
      else
        return 'no-notifications';
    },
    showNotificationCount: function(){
      if (this.newNotifications() > 0)
        return this.newNotifications();
      else
        return '';
    },
    notifications: function(){
      if (this.state.show)
        return 'notifications';
      else
        return 'notifications hidden';
    },
    toggleNotifications: function(){
      if (this.state.show)
        this.setState({show: false});
      else
        this.setState({show: true});
    },
    hide: function(){
      this.setState({show: false});
    },
    renderNotifications: function(){
      var notification = module.Notification;
      var navigator = this.props.navigator;
      var that = this;
      var notifications = this.props.collection.models.map(function(model){
        return (
          <notification 
            key={model.cid} 
            model={model} 
            navigator={navigator}
            parent={that} />
        );
      });
      return notifications;
    },
    render: function(){
      return (
        <div>
          <div 
            className={this.showNotificationClass()}
            onClick={this.toggleNotifications}>
            {this.showNotificationCount()}
          </div>
          <div className={this.notifications()}>
            <div className='top'>
              Notifications
            </div>
            {this.renderNotifications()}

            <div className='arrow-left' />
          </div>
        </div>
      );
    }
  });

  module.Notification = React.createClass({
    initTimeAgo: function(){
      $("abbr.timeago").timeago();
    },
    notificationClass: function(){
      if (this.props.model.get('checked'))
        return 'notification';
      else
        return 'notification new';
    },
    notificationText: function(text){
      var textElements = text.map(function(obj, index){
        if (obj['normal'])
          return <span key={index}>{obj.normal}</span>;
        else
          return <strong key={index}>{obj.bold}</strong>;
      });
      return textElements;
    },
    goTo: function(){
      var model = this.props.model;
      this.props.navigator.trigger(
        'notification',
        {
          id: model.get('idea_id'),
          highlight: function(){
            if (model.get('comment_id'))
              return {comment: model.get('comment_id')};
            else
              return {idea: model.get('idea_id')};
          }()
        }
      );
      this.props.parent.hide();
    },
    render: function(){
      var attr = this.props.model.attributes;
      return (
        <div 
          className={this.notificationClass()}
          onClick={this.goTo}>
          <div className='profile-image'>
            <img src={attr.image_url} />
          </div>
          <div className='notification-message'>
            {this.notificationText(attr.text)}
            <div className='meta'>
              <abbr 
                className='timeago' 
                title={attr.time}>
              </abbr>
              {this.initTimeAgo()}
            </div>
          </div>
        </div>
      );
    }
  });
  
  return module;
})(SimplyBetterApplication.Views || {});
