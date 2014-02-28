/** @jsx React.DOM */
SimplyBetterIdeas.Views = (function(views){
  var module = views;

  module.Idea = React.createClass({
     componentDidMount: function(){
      this.props.model.on('change', function() {
        this.forceUpdate();
      }.bind(this));
    },

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


    render: function(){
      var model = this.props.model;
      return (
        <li>
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
            {model.get('comments_count')} comments
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
            <div className="icon edit"></div>
            <div className="icon delete" onClick={this.destroy}></div>
          </div>
        </li>
      );
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
        return <ideaView key={item.cid} model={item} />
      });
      return <ul>{listItems}</ul>;
    }
  });
  
  return module;
})(SimplyBetterIdeas.Views || {});
