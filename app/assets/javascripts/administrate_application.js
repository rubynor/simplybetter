$(function(){

  var ideas_page = SBTools.isPresent($('body.applications.administrate_group'));

  $(document).on('page:load', function(){
    if (ideas_page){
      Backbone.history.stop();
      SimplyBetterIdeas.Init.start($('#manage-ideas').data().id);
    }
  });

  if (ideas_page){
    SimplyBetterIdeas.Init.start($('#manage-ideas').data().id);
  }
});
