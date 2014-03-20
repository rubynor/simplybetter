$(function(){

  var ideas_page = SBTools.isPresent($('body.applications.administrate_group'));
  if (ideas_page){
    SimplyBetterIdeas.Init.start($('#manage-ideas').data().id);
  }
});
