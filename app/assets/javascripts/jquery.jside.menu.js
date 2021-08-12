/*!  Plugin: jSide Menu (Responsive Side Menu) 
 *   Dependency: jQuery 3.4.1 & Material Design Iconic Font 2.0
 *   Author: Asif Mughal
 *   GitHub: https://github.com/CodeHimBlog
 *   URL: https://www.codehim.com
 *   License: MIT License
 *   Copyright (c) 2018 - 2019 - Asif Mughal
 */
/* File: jquery.jside.menu.js */
(function($){
     $.fn.jSideMenu = function(options){
    var setting = $.extend({
   		   jSidePosition: "position-left", //possible options position-left or position-right 
           jSideSticky: true, // menubar will be fixed on top, false to set static
           jSideSkin: "default-skin", // to apply custom skin, just put its name in this string
           
		   jSideTransition: 400, //Define the transition duration in milliseconds 
  
  		   }, options);
  
  return this.each(function() {
  var jSide, target, headHeight, devHeight, arrow, dimBackground;   
   
        target = $(this);
		
//Accessing DOM
  jSide = $(".menu-container, .menu-head");
  devHeight = $(window).height();
  headHeight = $(".menu-head").height();
  dHeading = $(".dropdown-heading");
  menuTrigger = $(".menu-trigger");
  arrow = $("<i></i>");
  dimBackground = $("<div>");
  
// Set the height of side menu according to the available height of device
$(target).css({
    'height' : devHeight-headHeight,

});

if (setting.jSideSticky == true){
  $(".menubar").addClass("sticky");
} else {
  $(".menubar").removeClass("sticky");
}

$(".menubar").addClass(setting.jSideSkin);
 $(jSide).addClass(setting.jSideSkin).addClass(setting.jSidePosition);

  if ($(jSide).hasClass("position-left")){
    $(".menu-trigger").addClass("left").removeClass("right");
  } else {
    $(".menu-trigger").removeClass("left").addClass("right");
  }

//Dropdown Arrow
    $(arrow).addClass("material-icons d-arrow").html("keyboard_arrow_down").appendTo(dHeading);
//Dim Layer	
    $(dimBackground).addClass("dim-overlay").appendTo("body");
//Dropdowns
$(dHeading).click(function(){
   $(this).parent().find("ul").slideToggle(setting.jSideTransition);
   $(this).find(".d-arrow").toggleClass("d-down");
    
 });

$(menuTrigger).click(function(){
   $(jSide).toggleClass("open");
   $(dimBackground).show(setting.jSideTransition);
   $(".menu-body").removeClass("visibility");
});

//close menu if user click outside of it
   $(window).click(function(e) {
    if ($(e.target).closest('.menu-trigger').length){
     return;}
    if ($(e.target).closest(jSide).length){
     return;}
    
 $(jSide).removeClass("open");
    if (!$(jSide).hasClass("open")) {
     $(dimBackground).hide(setting.jSideTransition);
        }
 $(".menu-body").addClass("visibility");
      });
   });
 };

})(jQuery);
/*   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */


// demo-only.js

/*!  Author: Asif Mughal
 *   URL: https://www.codehim.com
 *   License: MIT License
 *   Copyright (c) 2018 - 2019 - Asif Mughal
 */
$(function () {
	var a = $(".menu-container, .menu-head, .menubar");
	$(".menu-position").on("change", function () {
		$(a).not(".menubar").addClass($(this).val());
		$(".j-pos").html('jSidePosition: "position-right",');
		if ($(this).val() == "position-left") {
			$(a).removeClass("position-right");
			$(".j-pos").html('jSidePosition: "position-left",');
			$(".menu-trigger").removeClass("right").addClass("left")
		} else {
			$(a).removeClass("position-left");
			$(".menu-trigger").removeClass("left").addClass("right")
		}
	});
	$(".bg-color").on("change", function () {
		var b = $(this).val();
		$(a).css({
			background: b,
		});
		$(".bg-color-input").val(b)
	});
	$(".bg-color-input").on("input", function () {
		$(a).css({
			background: $(this).val(),
		})
	});
	$("#set-top").change(function () {
		$(".menubar").addClass("sticky");
		$(".j-sticky").html("jSideSticky: true,")
	});
	$("#set-st").change(function () {
		$(".menubar").removeClass("sticky");
		$(".j-sticky").html("jSideSticky: false,")
	});
	$(".theme-tray span").click(function () {
		var c = $(this).attr("class");
		$(".menubar").attr("class", c).addClass("menubar sticky");
		$(".menu-container").attr("class", c).addClass("menu-container position-left");
		$(".menu-head").attr("class", c).addClass("menu-head position-left");
		var b = 'jSideSkin:"' + c + '",';
		$(".j-skin").html(b)
	})
});
