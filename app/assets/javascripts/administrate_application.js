$(function(){
    if (SBTools.isPresent('body.applications.administrate_group')){
        $(document).on('click','.comments-toggle', function(e){
            $(e.target).closest('.list-group-item').find('#comments').toggle();
        });
    }
});

