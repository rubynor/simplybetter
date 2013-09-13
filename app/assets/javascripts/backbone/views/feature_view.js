SimplyBetterApplication.Features = (function(features){
    var module = features;
    module.showFeature = SimplyBetterApplication.Features.BaseItemView.extend ({
        template: function(){
            var tmp = "";
            $.ajax({
                url: SimplyBetterApplication.config.baseUrl + '/assets/backbone/templates/feature.html',
                method: 'GET',
                async: false,
                success: function(response){
                    tmp = response;
                }
            });
            return tmp;
        },
        el: '#featureVotingFeaturesModalContent'
    });

    return module;
}(SimplyBetterApplication.Features || {}));