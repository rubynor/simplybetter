// micro mustache - based on John Resig's Simple JS Template - http://ejohn.org/ - MIT Licensed
(function () {
    var cache = {};

    // Figure out if we're getting a template, or if we need to
    // load the template - and be sure to cache the result.
    window.tmpl = function tmpl(str, data) {
        var fn = !/\W/.test(str) ?
            cache[str] = cache[str] ||
                tmpl(document.getElementById(str).innerHTML) :

            // Generate a reusable function that will serve as a template
            // generator (and which will be cached).
            new Function("obj",
                "var p=[],print=function(){p.push.apply(p,arguments);};" +

                    // Introduce the data as local variables using with(){}
                    "with(obj){p.push('" +

                    // Convert the template into pure JavaScript
                    str
                        .replace(/[\r\t\n]/g, " ")
                        .split("{{").join("\t")
                        .replace(/((^|\}\})[^\t]*)'/g, "$1\r")
                        .replace(/\t=(.*?)\}\}/g, "',$1,'")
                        .split("\t").join("');")
                        .split("}}").join("p.push('")
                        .split("\r").join("\\'")
                    + "');}return p.join('');"
            );

        return data ? fn(data) : fn;
    };
})();

function HowHard(root, appKey, userName, userEmail) {
    this.root = root;
    this.appKey = appKey;
    this.userName = userName;
    this.userEmail = userEmail;

    this.features = {};
    this.featureTemplate = '<li class="feature"><h1>{{= title }}</h1><div class="desc">{{= description }}</div><div class="meta">by fixme</div><div class="vote-buttons"><a href="#up" class="up" onclick="window.$HowHard.vote({{= id }},1);"></a><div class="votes">{{= votes_count }}</div><a href="#down" class="down" onclick="window.$HowHard.vote({{= id }},-1);"></a></li>';

    var self = this;

    this.render = function () {
        var html = '<ol class="feature-container">';

        $.map(this.features, function (feature) {
            html += tmpl(self.featureTemplate, feature);
        });

        html += "</ol>";
        this.root.html(html);
    };

    // Store the instance in the browser (for actions, etc).
    // Could otherwise bind events - i.e. $('.up').click(fn)
    // here.
    window["$HowHard"] = this;
}


HowHard.prototype = {
    list: function () {
        var self = this;

        jQuery.ajax({
            url: "http://localhost:3000/features.js",
            type: "GET",
            dataType: 'jsonp',
            success: function (data) {
                $.map(data, function (e) { self.features[e.id] = e; });

                self.render();
            }
        });
    },
    vote: function (id, value) {
        var self = this;

        jQuery.ajax({
            type: "GET",
            url: "http://localhost:3000/vote.js",
            data: {
                token: self.appKey,
                feature_id: id,
                value: value,
                voter_email: self.userEmail,
                voter_name: self.userName
            },
            dataType: 'jsonp',
            success: function (data) {
                var newFeature = JSON.parse(data['feature']);
                self.features[newFeature.id] = newFeature;
                self.render();
            }
        });
    },
    comment: function (id, body) {
        var self = this;

        jQuery.ajax({
            type: "GET",
            url: "http://localhost:3000/comments/create.js",
            data: {
                token: self.appKey,
                feature_id: id,
                body: body,
                voter_email: self.userEmail,
                voter_name: self.userName
            },
            dataType: 'jsonp',
            success: function (data) {
                self.features[id] = JSON.parse(data['feature']);
                self.render();
            }
        });
    },
    destroyComment: function (id) {
        var self = this;

        jQuery.ajax({
            type: "GET",
            url: "http://localhost:3000/comments/destroy.js",
            data: {
                token: self.appKey,
                feature_id: id,
                voter_email: self.userEmail,
                voter_name: self.userName
            },
            dataType: 'jsonp',
            success: function (data) {
                delete self.features[id];
                self.render();
            }
        });
    }

};
