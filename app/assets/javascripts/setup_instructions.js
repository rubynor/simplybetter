$(function(){

    if (SBTools.isPresent('.applications.show')){
        hljs.initHighlightingOnLoad();

        $('.icon').each(function(index){
            $(this).on('click', function(e){
                setSelected(e.target);
                $("#application-code").removeClass('invisible');
            });
        });

        function setSelected(item){
            $('.icon').removeClass('selected');
            $(item).addClass('selected');
            setIconKey(item);
        };

        function setIconKey(item){
            var copyCode = $('pre.copy-code code');
            var text = copyCode.html();
            text = text.replace(/icon = .*".*"/,"icon = <span class='hljs-string'> \"" + $(item).data('title') + "\"");
            copyCode.empty().append(text);
        };
    }
});
