$(function(){

    if (SBTools.isPresent($('body.applications.show'))){
        hljs.initHighlightingOnLoad();

        $('form.icon_select label').on('click', function(e){
          setTimeout( function () {
            $(e.target).closest('form').submit();
          }, 50 );
        });

    }
});
