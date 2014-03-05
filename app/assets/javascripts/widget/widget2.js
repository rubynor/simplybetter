//= require zepto
//= require zepto_animations
//= require react
//= require underscore
//= require backbone
//= require backbone/widget/setup
//= require_tree ../backbone/widget

$(function(){
  // It is not possible to have a dynamic navbar and a flexible
  // div beneath that stretches to the bottom and uses overflow-y: scroll
  // We will set the height with javascript
    var resize = function(){
        $('#simplybetterIdeasModalContent')
            .height($(window).height() - $('#simplybetterNavbar').height());
    }
    $(window).on('resize', function(){
        resize();
    });
    setTimeout(function(){
        resize();
    },2000);
});
