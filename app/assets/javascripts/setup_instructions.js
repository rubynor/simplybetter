$(function(){

    if (SBTools.isPresent($('body.applications.show'))){
        hljs.initHighlightingOnLoad();

        $('label').on('click', function(e){
          $(e.target).closest('form').submit();
        });

    }
});
