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

    this.features = [];
    this.featureTemplate = '<li class="feature"><h1>{{= title }}</h1><div class="desc">{{= description }}</div><div class="meta">by {{= creator_name }}</div><div class="vote-buttons"><a href="#up" class="up" onclick="window.$HowHard.vote({{= id }},1);"></a><div class="votes">{{= votes_count }}</div><a href="#down" class="down" onclick="window.$HowHard.vote({{= id }},-1);"></a></div></li>'; // <a href="#more" onclick="window.$HowHard.comments({{= id }})">expand</a>
    this.commentTemplate = '<li class="comment"><div class="body">{{= body }}</div><div class="meta">by {{= creator_name }}</div><div class="vote-buttons"><a href="#up" class="up" onclick="window.$HowHard.like({{= feature_id }}, {{= id }}, 1);"></a><div class="votes">{{= votes_count }}</div><a href="#down" class="down" onclick="window.$HowHard.like({{= feature_id }}, {{= id }}, -1);"></a></div></li>';

    var self = this;

    this.render = function () {
        var html = '<div class="featureVotingCloseButton"></div><div class="features_inner"><ol class="feature-container">';
        $.map(this.features, function (feature) {
            html += tmpl(self.featureTemplate, feature);

            html += '<ol class="comments">';
            $.map(feature.comments, function (comment) {
                html += tmpl(self.commentTemplate, comment);
            });
            html += '</ol>';

        });
        html += '</ol>';



        this.root.html(html);
        $('body').append('<div id="fatureVotingBackdropLayer" style="display:none"></div>');
        $('.featureVotingCloseButton').on('click', function(){
            $('#fatureVotingBackdropLayer').hide();
            $('#featureVotingFeaturesModal').hide();
            $(this).hide();
            $('.howHardBtn').show();
        });
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
            url: "http://localhost:3000/features.json",
            type: "GET",
            dataType: 'json',
            data: {
                token: self.appKey
            },
            success: function (data) {
                $.map(data, function (e) { self.features.push(e); });
                self.render();
            }
        });
    },
    vote: function (featureId, value) {
        var self = this;

        jQuery.ajax({
            type: "GET",
            url: "http://localhost:3000/vote.json",
            data: {
                token: self.appKey,
                feature_id: featureId,
                value: value,
                voter_email: self.userEmail,
                voter_name: self.userName
            },
            dataType: 'json',
            success: function (data) {
                var index;
                // This is really ugly. Is there a way to keep
                // sorting, AND use hash?
                $.each(self.features, function(i,f){
                    if (f.id === featureId){
                        index = i;
                    }
                });
                self.features[index] = data;
                self.render();
            }
        });
    },
    like: function (featureId, commentId, value) {
        var self = this;

        jQuery.ajax({
            type: "GET",
            url: "http://localhost:3000/vote.json",
            data: {
                token: self.appKey,
                comment_id: commentId,
                value: value,
                voter_email: self.userEmail,
                voter_name: self.userName
            },
            dataType: 'json',
            success: function (data) {
                self.features[featureId] = data;
                self.render();
            }
        });
    },
    comment: function (id, body) {
        var self = this;

        jQuery.ajax({
            type: "GET",
            url: "http://localhost:3000/features/" + id + "/comments/create",
            data: {
                token: self.appKey,
                feature_id: id,
                body: body,
                voter_email: self.userEmail,
                voter_name: self.userName
            },
            dataType: 'json',
            success: function (data) {
                self.features[id] = data; //TODO: or should it just return the comment?
                self.render();
            }
        });
    },
    destroyComment: function (id) {
        var self = this;

        jQuery.ajax({
            type: "DELETE",
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
