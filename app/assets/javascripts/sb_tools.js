SBTools = (function(){
    var sb = {};

    sb.isPresent = function(jquerySelector){
        return jquerySelector.length > 0 ? true : false
    }
    
    return sb;
}());

