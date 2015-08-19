SBTools = (function(){
    var sb = {};

    sb.isPresent = function(jquerySelector){
        return jquerySelector.length ? true : false
    };
    
    return sb;
}());

