SimplyBetterApplication.Template = {
    get: function(templateId){
        if (!this.templates) {this.templates = {};}
        
        var template = this.templates[templateId];
        if (!template){
            var tmp = "";
            $.ajax({
                url: SimplyBetterApplication.config.templateUrl + templateId,
                method: 'GET',
                async: false,
                success: function(response){
                    tmp = response;
                }
            });
            template = _.template(tmp);
            this.templates[templateId] = template;
        }
        return template;
    }
}

