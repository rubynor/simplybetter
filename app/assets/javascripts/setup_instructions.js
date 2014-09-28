$(function(){

    if (SBTools.isPresent($('body.applications.show'))){
        hljs.initHighlightingOnLoad();

        //TODO OMA: When is this needed? Should be for something more specific than 'label'. On reading this, I'm not sure what the target is.
        $('label').on('click', function(e){
          $(e.target).closest('form').submit();
        });

    }
});
