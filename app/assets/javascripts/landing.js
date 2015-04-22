//= require jquery
//= require jquery_ujs
//= require angular-1.2.18/angular
//= require angular-1.2.18/angular-resource
//= require angular/landing_page
//= require_tree ./angular/landing_page

// JavaScript Document
$(document).ready(function() {


  $(window).scroll(function() {
    var scroll = $(window).scrollTop();
    if (scroll > 10) {
      $("header").addClass("scrollHeader");
    }else {
      $("header").removeClass("scrollHeader");
    }
  })

  if(!(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) ) {
    $('.contact-section').addClass('parallax')
  }

  function scroll_if_anchor(href) {
    href = typeof(href) == "string" ? href : $(this).attr("href");

    // You could easily calculate this dynamically if you prefer
    if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
      var fromTop = 50;
    } else {
      var fromTop = 68;
    }

    // If our Href points to a valid, non-empty anchor, and is on the same page (e.g. #foo)
    // Legacy jQuery and IE7 may have issues: http://stackoverflow.com/q/1593174
    if(href.indexOf("#") == 0) {
      var $target = $(href);

      // Older browser without pushState might flicker here, as they momentarily
      // jump to the wrong position (IE < 10)
      if($target.length) {
        $('html, body').animate({ scrollTop: $target.offset().top - fromTop });
        if(history && "pushState" in history) {
          history.pushState({}, document.title, window.location.pathname + href);
          return false;
        }
      }
    }
  }

// When our page loads, check to see if it contains and anchor
  scroll_if_anchor(window.location.hash);

  $("body").on("click", "li a, a.fLogo", scroll_if_anchor);


  jQuery('.parallax').each(function() {
    var $self = jQuery(this);

    var url = $self.css('background-image').replace('url', '').replace('(', '').replace(')', '').replace('"', '').replace('"', '');
    var bgImg = jQuery('<img />');
    bgImg.hide();
    bgImg.bind('load', function()
    {
      var bgImgHeight = jQuery(this).height();
      //jQuery(this).attr("style", "");
      $self.height(bgImgHeight);
      var section_height = jQuery(this).height();
      $self.height(section_height);
      var rate = (section_height / jQuery(document).height()) * 1;
      var distance = jQuery(window).scrollTop() - $self.offset().top;
      var bpos = -(distance * rate);
      $self.css({
        'background-position': 'center ' + bpos + 'px'
      });
      jQuery(window).bind('scroll',
          function() {
            var distance = jQuery(window).scrollTop() - $self.offset().top;
            var bpos = -(distance * rate);
            $self.css({
              'background-position': 'center ' + bpos + 'px'
            })
          })
    });
    $self.find("img").remove();
    $self.append(bgImg);
    bgImg.attr('src', url);

  });

})
