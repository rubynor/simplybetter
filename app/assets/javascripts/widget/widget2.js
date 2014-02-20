//= require zepto
//= require zepto_animations
//= require underscore
//= require backbone
//= require widget/setup
//= require_tree ./backbone

$(function(){
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
