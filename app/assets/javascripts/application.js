// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require masonry/jquery.masonry
//= require masonry/jquery.event-drag
//= require masonry/jquery.imagesloaded.min
//= require masonry/jquery.infinitescroll.min
//= require masonry/modernizr-transitions
//= require masonry/box-maker
//= require masonry/jquery.loremimages.min
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require jquery.validate.localization/messages_zh
//= require jquery.validate.localization/messages_ja
//= requrie turbolinks
//= requre jquery.form
//= require_tree .


//$(document).ready(function(){
    // remove #_=_ from url
    // #_=_ is a bug when using omniauth-facebook, facebook add this to the end of url to cause jquery expression error
    if (window.location.href.indexOf('#_=_') > 0) {
        window.location = window.location.href.replace(/#.*/, '');
}//});

function flash(data) {
    $(".alert span").text(data);
    $(".alert").css("opacity", "100");
    $(".alert").slideDown('slow');
    window.setTimeout(function() {
        $(".alert").slideUp(500, function(){
            $(this).hide(); 
        });
    }, 1500);
}


function getUrlParameters(parameter, staticURL, decode) {
    var currLocation = (staticURL.length) ? staticURL : window.location.search,
    returnBool = true;
    // test if the url has search section
    if(currLocation.length) {
        var parArr = currLocation.split("?")[1].split("&");

        for (var i = 0; i < parArr.length; i++) {
            parr = parArr[i].split("=");
            if (parr[0] == parameter) {
                return (decode) ? decodeURIComponent(parr[1]) : parr[1];
                returnBool = true;
            } else {
                returnBool = false;
            }
        }
    } else {
        returnBool = false;
    }
    
    if (!returnBool) return false;
}

function masonryNow(itemSelector, container, gutter) {
    container.masonry({
        itemSelector: itemSelector,
        gutter: gutter,
        isAnimated: !Modernizr.csstransitions, 
        animationOptions: {
          duration: 700,
          easing: 'linear',
          queue: false
        }
    }); 
}

function popup(data, target) {
    var options = {
        placement: 'top',
        trigger: 'manual',
        content: function () {
            return data;
        },
        container: 'body',
        html: 'true'
      };

      target.popover(options);
      target.popover('show');
      window.setTimeout(function(){
        target.popover('destroy');},2000);
}