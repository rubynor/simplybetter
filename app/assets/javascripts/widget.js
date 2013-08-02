function HowHard(root) {
    this.root = root;
}

HowHard.prototype.features = function () {
    var self = this;

    jQuery.ajax({
        url: "/features",
        type: "GET",
        data: {},
        success: function(data) {
            self.root.html(data);
        }
    });

};
