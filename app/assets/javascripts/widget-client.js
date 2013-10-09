(function(){
    var appKey = _smplyBtr.appKey;
    var email = _smplyBtr.email;
    var name = _smplyBtr.name;

    var urlRoot = 'http://simplybetter.io';
    var cssId = 'simplyBetterWidgetStyle';
    if (!document.getElementById(cssId)){
      var head  = document.getElementsByTagName('head')[0];
      var link  = document.createElement('link');
      link.id   = cssId;
      link.rel  = 'stylesheet';
      link.type = 'text/css';
      link.href = urlRoot + '/assets/widget-client-include.css';
      link.media = 'all';
      head.appendChild(link);
    }
    var e = document.createElement('div');
    e.innerHTML = '<div id="featureVotingBackdropLayer" style="display: none;"></div><div id="simplybetterIframeWrapper" style="display: none;"><div id="featureVotingCloseButton">&times;</div><iframe class="simplybetterIframe" src="' + urlRoot + '/widget?appkey='+appKey+'&email='+email+'&name='+name+'" frameborder="0", scrolling="no"></iframe></div><div id="simplybetterActivateButton"></div>'
    document.getElementsByTagName('body')[0].appendChild(e);

    var iframeWrapper = document.getElementById('simplybetterIframeWrapper');
    var backdrop = document.getElementById('featureVotingBackdropLayer');
    document.getElementById('simplybetterActivateButton').onclick = function() {
        iframeWrapper.removeAttribute('style');
        backdrop.removeAttribute('style');
    };
    document.getElementById('featureVotingCloseButton').onclick = function() {
        iframeWrapper.setAttribute('style','display: none;');
        backdrop.setAttribute('style', 'display: none;');
    };
})();
