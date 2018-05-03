// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery

//= require rails-ujs
//= require turbolinks
//= require_tree .

$(function() {
    var ulLi = $('nav ul > li'),
        fa = $('nav ul > li:last-of-type a .fa');

    $('nav ul').append('<ol></ol>');

    $('nav').each(function() {
        for (var i=0; i <= ulLi.length - 3; i++) {
            $('nav ul > ol').append("<li>"+ i +"</li>");
            $('nav ul > ol > li').eq(i).html(ulLi.eq(i+1).html());
        }
    });

    $('nav ul > li:last-of-type').on('click', function() {
        fa.toggleClass('fa-bars');
        fa.toggleClass('fa-times');
        $(this).parent().children('ol').slideToggle(500);
    });
});
