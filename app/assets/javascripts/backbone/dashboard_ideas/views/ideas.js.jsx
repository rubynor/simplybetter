/** @jsx React.DOM */
SimplyBetterIdeas.Views = (function(views){
  var module = views;

  module.Navbar = React.createClass({
    componentWillMount: function(){
      this.callback = (function() {
        this.forceUpdate();
      }).bind(this);

      this.props.router.on("route", this.callback);
      this.props.collection.on("all", this.callback);
    },
    componentWillUnmount: function(){
      this.props.router.off("route", this.callback);
      this.props.collection.off("all", this.callback);
    },
    active: function(name){
      if (name == this.props.router.current)
        return 'active';
    },
    render: function(){
      var ideas = SimplyBetterIdeas.Views.Ideas;
      return (
        <div>
          <div className='ideas-navigate'>
            <a href='#all' className={this.active('all')}>All</a>
            <a href='#visible' className={this.active('visible')}>Visible</a>
            <a href='#hidden' className={this.active('hidden')}>Hidden</a>
          </div>
          <ideas collection={this.props.collection} router={this.props.router} />
        </div>
      );
    }
  });

  module.Comment = React.createClass({
    render: function(){
      var model = this.props.model.attributes;
      return (
        <li className='comment-item'>
          <div className="avatar">
            <img src={model.gravatar_url} />
          </div>
          <div className="content">
            <div className="meta"><span className="username">{ model.creator_name }</span> on <span>{ model.updated_at }</span></div>
            <div className="comment-body">
                { model.body }
            </div>
          </div>
        </li>
      );
    }
  });

  module.IdeaShow = React.createClass({
    getInitialState: function(){
      return {showComments: false};
    },
    toggleComments: function(){
      var that = this;
      var commentState = function(state){
        that.setState({showComments: state});
      }
      if (this.state.showComments){
        commentState(false);
      } else {
        commentState(true);
      }
    },

    renderComments: function(){
      if (this.state.showComments){
        var model = this.props.model;
        if (model.comments){
          var commentItem = module.Comment;
          var commentList = model.comments.map(function(item){
            return <commentItem key={item.cid} model={item} />;
          });
          return <ul>{commentList}</ul>;
        } else {
          return <p>No comments</p>;
        }
      }
    },

    destroy: function(){
      if (confirm("Are you sure?")){
        this.props.model.destroy();
      }
    },

    classForVisibility: function(){
      if (this.props.model.get('idea_group_id') === 1){
        return 'visible'
      } else {
        return 'not-visible'
      }
    },

    changeVisibility: function(){
      var model = this.props.model;
      var data = {};
      if (model.get('idea_group_id') === 1){
        data = {'idea_group_id': null}
      } else {
        data = {'idea_group_id': 1}
      }
      model.save(data,{patch: true})
    },

    edit: function(){
      this.props.parent.setState({edit: true});
    },

    render: function(){
      var model = this.props.model;

      return (
        <li className='idea'>
          <h1>{model.get('title')}</h1>
          <p>{model.get('description')}</p>
          <div className='meta'>
            <div className='icon upvote'></div>
            <span className='upvotes'>
              {model.get('upvotes')}
            </span>
            <span className='dot'>•</span>
            <div className='icon downvote'></div>
            <span className='downvotes'>
              {model.get('downvotes')} 
            </span>
            <span className='dot'>•</span>
            <div className='icon comment'></div>
            <span className='comment' onClick={this.toggleComments}>{model.get('comments_count')} comments
            </span>
            <span className='dot'>•</span>
            by <span className='user'>{model.get('creator_name')} </span>
            on <span className='time'>{model.get('updated_at')} </span>
          </div>
          <div className={this.classForVisibility()+'-overlay'}></div>
          <div className="options">
            <div 
              className={'icon ' + this.classForVisibility()}
              onClick={this.changeVisibility}
            ></div>
            <div className="icon edit" onClick={this.edit}></div>
            <div className="icon delete" onClick={this.destroy}></div>
          </div>
          <div className='comments'>
            {this.renderComments()}
          </div>
        </li>
      );
    }
  });

  module.IdeaEdit = React.createClass({
    handleChange: function(event){
      var attribute = event.target.name;
      this.props.model.set(attribute,event.target.value);
    },
    show: function(){
      this.props.parent.setState({edit: false});
    },
    saveAndShow: function(){
      this.show();
      this.props.model.save({patch: true});
    },
    cancel: function(){
      this.show();
      this.props.model.fetch();
    },
    render: function(){
      var model = this.props.model;
      return (
        <li className='idea'>
          <input 
            type="text" 
            name='title' 
            onChange={this.handleChange} 
            value={model.get('title')}
          />
          <textarea
            name='description'
            onChange={this.handleChange}
            value={model.get('description')}
          />
          <button onClick={this.saveAndShow}>Save</button>
          <button onClick={this.cancel}>Cancel</button>
        </li>
      );
    }
  });

  module.Idea = React.createClass({
    getInitialState: function(){
      return {edit: false};
    },
    render: function(){
      var show = module.IdeaShow;
      var edit = module.IdeaEdit;

      if (this.state.edit){
        return <edit model={this.props.model} parent={this}/>;
      } else {
        return <show model={this.props.model} parent={this}/>;
      }
    }
  });

  module.Ideas = React.createClass({
    filter: function(conditions){
      return this.props.collection.where(conditions);
    },
    collection: function(){
      var current = this.props.router.current;
      if (current === 'visible'){
        return this.filter({idea_group_id: 1})
      } else if (current === 'hidden'){
        return this.filter({idea_group_id: null})
      } else {
        return this.props.collection.models;
      }
    },

    render: function(){
      var ideaView = module.Idea;
      var collection = this.collection();
      var listItems = collection.map(function(item){
        return <ideaView key={item.cid} model={item} />;
      });
      return <ul>{listItems}</ul>;
    }
  });
  
  return module;



})(SimplyBetterIdeas.Views || {});
