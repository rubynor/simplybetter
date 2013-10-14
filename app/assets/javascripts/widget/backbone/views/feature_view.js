SimplyBetterApplication.Features = (function(features){
    var module = features;
    module.showFeature = SimplyBetterApplication.Features.BaseItemView.extend ({
        template: function(){
            var tmp = "";
            $.ajax({
                url: SimplyBetterApplication.config.templateUrl + 'feature.html',
                method: 'GET',
                async: false,
                success: function(response){
                    tmp = response;
                }
            });
            return tmp;
        },
        close: function(){
            this.remove();
        }
    });

    return module;
}(SimplyBetterApplication.Features || {}));