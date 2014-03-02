/** @jsx React.DOM */
SimplyBetterIdeas.Views = (function(views){
  var module = views;

  module.Comment = React.createClass({
    render: function(){
      var model = this.props.model.attributes;
      return (
        <li className='comment'>
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
    destroy: function(){
      this.props.model.destroy();
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
      var comments = function(){
        if (model.comments){
          var commentItem = module.Comment;
          var commentList = model.comments.map(function(item){
            return <commentItem key={item.cid} model={item} />;
          });
          return <ul>{commentList}</ul>;
        } else {
          return <p>No comments</p>;
        }
      };
      return (
        <li className='idea'>
          <h1>{model.get('title')}</h1>
          <p>{model.get('description')}</p>
          <div className='meta'>
            <div className='icon upvote'></div>
            <span className='upvotes'>
              {model.get('upvotes')}
            </span>
            &nbsp;•&nbsp;
            <div className='icon downvote'></div>
            <span className='downvotes'>
              {model.get('downvotes')} 
            </span>
            &nbsp;•&nbsp;
            <div className='icon comment'></div>
            <span onClick={this.toggleComments}>{model.get('comments_count')} comments
            </span>
            •
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
            {comments()}
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
        <li>
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
    componentDidMount: function(){
      this.props.model.on('change', function() {
        this.forceUpdate();
      }.bind(this));
    },
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
    componentDidMount: function(){
      this.props.myCollection.on('all', function() {
        this.forceUpdate();
      }.bind(this));
    },

    render: function(){
      var ideaView = module.Idea;
      var listItems = this.props.myCollection.map(function(item){
        return <ideaView key={item.cid} model={item} />;
      });
      return <ul>{listItems}</ul>;
    }
  });
  
  return module;



})(SimplyBetterIdeas.Views || {});
