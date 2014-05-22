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
//= require jquery.lazyload
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
    var currLocation = (staticURL.length) ? staticURL: window.location.search,
    parArr = currLocation.split("?")[1].split("&"),
    returnBool = true;

    for (var i = 0; i < parArr.length; i++) {
        parr = parArr[i].split("=");
        if (parr[0] == parameter) {
            return (decode) ? decodeURIComponent(parr[1]) : parr[1];
            returnBool = true;
        } else {
            returnBool = false;
        }
    }

    if (!returnBool) return false;
}