// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

$(function() {
    $("#clicker").click(function(event) {
        var button = $(this);
        button.attr("disabled", "disabled");
        button.css("background-color", "#666666");

        var counter = $("#counter");
        counter.html("3");
        counter.css("color", "#009900");

        setTimeout(function() {
            var counter = $("#counter");
            counter.html("2");
            counter.css("color", "#FFFB00");


            setTimeout(function() {
                var counter = $("#counter");
                counter.html("1");
                counter.css("color", "#990000");

                setTimeout(function() {
                    var counter = $("#counter");
                    counter.html("0");
                    counter.css("color", "black");

                    $.ajax({
                        url:     "/api/snap",
                        method:  "POST",
                        success: function(data, status, xhr) {
                            var counter = $("#counter");
                            counter.html("&nbsp;");
                            var button = $("#clicker");
                            button.removeAttr("disabled");
                            button.css("background-color", "black");
                        },
                        error:   function(xhr, status, message) {
                            console.log(message);
                            var counter = $("#counter");
                            counter.html("!");
                            counter.css("color", "#990000");
                        }
                    });
                }, 1000);
            }, 1000);
        }, 1000);
    });
});
