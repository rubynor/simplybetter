//= require jquery
//= require jquery_ujs
//= require angular/angular
//= require angular/angular-resource
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

});
