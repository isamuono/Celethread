var resizeFlg;    //setTimeoutの待機中かを判定するフラグ

function windowResizeFunc(){

  //resizeFlgに値が設定されている場合は、待ち時間中なのでリセットする
  if (resizeFlg !== false) {
      clearTimeout(resizeFlg);
  }
  //300ms待機後にリサイズ処理を実施する
  resizeFlg = setTimeout( function() {
      //resizeElement();    //リサイズを実施する処理
  }, 300);
}

//window.addEventListener("resize", windowResizeFunc);
//window.addEventListener('load', categorySet());
window.addEventListener('load', colorElement());

/* Sidenav Overlay */
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
  //document.getElementById("main").style.backgroundColor = "#85d1d1";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
  document.getElementById("main").style.backgroundColor = "#a2efef";
}


/* Dropdown List  */
var dropdown = document.getElementsByClassName("dropdown-btn");
var i;

for (i = 0; i < dropdown.length; i++) {
  dropdown[i].addEventListener("click", function() {
    //this.classList.toggle("active");
    var dropdownContainer = this.nextElementSibling; // "dropdown-btn"とclass指定された<a>タグと
                                                     // 隣接する兄弟要素の<div>タグを取得
    if (dropdownContainer.style.display === "block") {
      dropdownContainer.style.display = "none";
    } else {
      dropdownContainer.style.display = "block";
    }
  });
}

var deepdropdown = document.getElementsByClassName("deep-dropdown-btn");

for (i = 0; i < deepdropdown.length; i++) {
  deepdropdown[i].addEventListener("click", function() {
    //this.classList.toggle("active");
    var dropdownContainer = this.nextElementSibling;
    if (dropdownContainer.style.display === "block") {
      dropdownContainer.style.display = "none";
    } else {
      dropdownContainer.style.display = "block";
    }
  });
}

function colorElement(){
  const color = document.getElementsByClassName("color-icons");
  const color_arr = Array.from(color);
  
  //for ( i = 0; i < color.length; i++ ) {
	  //const color = document.querySelector(".color-icon");
	  const forEach_arr = color_arr.forEach(function (value) {
	    if (value.firstElementChild.innerHTML == "rgb(0, 0, 0)") {
	      value.style.backgroundColor = "black";
	    } else if (value.firstElementChild.innerHTML == "rgb(128, 128, 128)") {
	      value.style.backgroundColor = "gray";
	    } else if (value.firstElementChild.innerHTML == "rgb(70, 130, 180)") {
	      value.style.backgroundColor = "steelblue";
	    } else if (value.firstElementChild.innerHTML == "rgb(0, 0, 128)") {
	      value.style.backgroundColor = "navy";
	    } else if (value.firstElementChild.innerHTML == "rgb(0, 0, 255)") {
	      value.style.backgroundColor = "blue";
	    } else if (value.firstElementChild.innerHTML == "rgb(65, 105, 225)") {
	      value.style.backgroundColor = "royalblue";
	    } else if (value.firstElementChild.innerHTML == "rgb(30, 144, 255)") {
	      value.style.backgroundColor = "dodgerblue";
	    } else if (value.firstElementChild.innerHTML == "rgb(0, 191, 255)") {
	      value.style.backgroundColor = "deepskyblue";
	    } else if (value.firstElementChild.innerHTML == "rgb(135, 206, 250)") {
	      value.style.backgroundColor = "lightskyblue";
	    } else if (value.firstElementChild.innerHTML == "rgb(0, 255, 255)") {
	      value.style.backgroundColor = "cyan";
	    } else if (value.firstElementChild.innerHTML == "rgb(0, 139, 139)") {
	      value.style.backgroundColor = "darkcyan";
	    } else if (value.firstElementChild.innerHTML == "rgb(0, 128, 0)") {
	      value.style.backgroundColor = "green";
	    } else if (value.firstElementChild.innerHTML == "rgb(60, 179, 113)") {
	      value.style.backgroundColor = "mediumseagreen";
	    } else if (value.firstElementChild.innerHTML == "rgb(152, 251, 152)") {
	      value.style.backgroundColor = "palegreen";
	    } else if (value.firstElementChild.innerHTML == "rgb(173, 255, 47)") {
        value.style.backgroundColor = "greenyellow";
      } else if (value.firstElementChild.innerHTML == "rgb(0, 255, 0)") {
        value.style.backgroundColor = "lime";
      } else if (value.firstElementChild.innerHTML == "rgb(154, 205, 50)") {
	      value.style.backgroundColor = "yellowgreen";
	    } else if (value.firstElementChild.innerHTML == "rgb(189, 183, 107)") {
	      value.style.backgroundColor = "darkkhaki";
	    } else if (value.firstElementChild.innerHTML == "rgb(240, 230, 140)") {
	      value.style.backgroundColor = "khaki";
	    } else if (value.firstElementChild.innerHTML == "rgb(255, 244, 80)") {
	      value.style.backgroundColor = "#fff450";
	    } else if (value.firstElementChild.innerHTML == "rgb(255, 215, 0)") {
	      value.style.backgroundColor = "gold";
	    } else if (value.firstElementChild.innerHTML == "rgb(252, 200, 0)") {
	      value.style.backgroundColor = "#fcc800";
	    } else if (value.firstElementChild.innerHTML == "rgb(255, 165, 0)") {
	      value.style.backgroundColor = "orange";
	    } else if (value.firstElementChild.innerHTML == "rgb(255, 140, 0)") {
	      value.style.backgroundColor = "darkorange";
	    } else if (value.firstElementChild.innerHTML == "rgb(143, 101, 82)") {
	      value.style.backgroundColor = "#8f6552";
	    } else if (value.firstElementChild.innerHTML == "rgb(139, 69, 19)") {
	      value.style.backgroundColor = "saddlebrown";
	    } else if (value.firstElementChild.innerHTML == "rgb(178, 34, 34)") {
	      value.style.backgroundColor = "firebrick";
	    } else if (value.firstElementChild.innerHTML == "rgb(255, 99, 71)") {
	      value.style.backgroundColor = "tomato";
	    } else if (value.firstElementChild.innerHTML == "rgb(255, 69, 0)") {
	      value.style.backgroundColor = "orangered";
	    } else if (value.firstElementChild.innerHTML == "rgb(255, 0, 0)") {
        value.style.backgroundColor = "red";
      } else if (value.firstElementChild.innerHTML == "rgb(220, 20, 60)") {
	      value.style.backgroundColor = "crimson";
	    } else if (value.firstElementChild.innerHTML == "rgb(231, 53, 98)") {
	      value.style.backgroundColor = "#e73562";
	    } else if (value.firstElementChild.innerHTML == "rgb(255, 20, 147)") {
	      value.style.backgroundColor = "deeppink";
	    } else if (value.firstElementChild.innerHTML == "rgb(255, 105, 180)") {
	      value.style.backgroundColor = "hotpink";
	    } else if (value.firstElementChild.innerHTML == "rgb(255, 182, 193)") {
	      value.style.backgroundColor = "lightpink";
	    } else if (value.firstElementChild.innerHTML == "rgb(238, 130, 238)") {
	      value.style.backgroundColor = "violet";
	    } else if (value.firstElementChild.innerHTML == "rgb(139, 0, 139)") {
	      value.style.backgroundColor = "darkmagenta";
	    } else if (value.firstElementChild.innerHTML == "rgb(148, 0, 211)") {
	      value.style.backgroundColor = "darkviolet";
	    }
    });
	//}
	
	//for ( i = 0; i < chcolor.length; i++ ) {
	  const chcolor = document.getElementById("color-icon");
	  const rgb = document.getElementById("rgb").textContent;
	  
	    if (rgb == "rgb(0, 0, 0)") {
	      chcolor.style.backgroundColor = "black";
	    } else if (rgb == "rgb(128, 128, 128)") {
	      chcolor.style.backgroundColor = "gray";
	    } else if (rgb == "rgb(70, 130, 180)") {
	      chcolor.style.backgroundColor = "steelblue";
	    } else if (rgb == "rgb(0, 0, 128)") {
	      chcolor.style.backgroundColor = "navy";
	    } else if (rgb == "rgb(0, 0, 255)") {
	      chcolor.style.backgroundColor = "blue";
	    } else if (rgb == "rgb(65, 105, 225)") {
	      chcolor.style.backgroundColor = "royalblue";
	    } else if (rgb == "rgb(30, 144, 255)") {
	      chcolor.style.backgroundColor = "dodgerblue";
	    } else if (rgb == "rgb(0, 191, 255)") {
	      chcolor.style.backgroundColor = "deepskyblue";
	    } else if (rgb == "rgb(135, 206, 250)") {
	      chcolor.style.backgroundColor = "lightskyblue";
	    } else if (rgb == "rgb(0, 255, 255)") {
	      chcolor.style.backgroundColor = "cyan";
	    } else if (rgb == "rgb(0, 139, 139)") {
	      chcolor.style.backgroundColor = "darkcyan";
	    } else if (chcolor.firstElementChild == "rgb(0, 128, 0)") {
	      chcolor.style.backgroundColor = "green";
	    } else if (chcolor.firstElementChild == "rgb(60, 179, 113)") {
	      chcolor.style.backgroundColor = "mediumseagreen";
	    } else if (chcolor.firstElementChild == "rgb(152, 251, 152)") {
	      chcolor.style.backgroundColor = "palegreen";
	    } else if (chcolor.firstElementChild == "rgb(173, 255, 47)") {
        chcolor.style.backgroundColor = "greenyellow";
      } else if (chcolor.firstElementChild == "rgb(0, 255, 0)") {
        chcolor.style.backgroundColor = "lime";
      } else if (chcolor.firstElementChild == "rgb(154, 205, 50)") {
	      chcolor.style.backgroundColor = "yellowgreen";
	    } else if (chcolor.firstElementChild == "rgb(189, 183, 107)") {
	      chcolor.style.backgroundColor = "darkkhaki";
	    } else if (chcolor.firstElementChild == "rgb(240, 230, 140)") {
	      chcolor.style.backgroundColor = "khaki";
	    } else if (chcolor.firstElementChild == "rgb(255, 244, 80)") {
	      chcolor.style.backgroundColor = "#fff450";
	    } else if (chcolor.firstElementChild == "rgb(255, 215, 0)") {
	      chcolor.style.backgroundColor = "gold";
	    } else if (chcolor.firstElementChild == "rgb(252, 200, 0)") {
	      chcolor.style.backgroundColor = "#fcc800";
	    } else if (chcolor.firstElementChild == "rgb(255, 165, 0)") {
	      chcolor.style.backgroundColor = "orange";
	    } else if (chcolor.firstElementChild == "rgb(255, 140, 0)") {
	      chcolor.style.backgroundColor = "darkorange";
	    } else if (chcolor.firstElementChild == "rgb(143, 101, 82)") {
	      chcolor.style.backgroundColor = "#8f6552";
	    } else if (chcolor.firstElementChild == "rgb(139, 69, 19)") {
	      chcolor.style.backgroundColor = "saddlebrown";
	    } else if (chcolor.firstElementChild == "rgb(178, 34, 34)") {
	      chcolor.style.backgroundColor = "firebrick";
	    } else if (chcolor.firstElementChild == "rgb(255, 99, 71)") {
	      chcolor.style.backgroundColor = "tomato";
	    } else if (chcolor.firstElementChild == "rgb(255, 69, 0)") {
	      chcolor.style.backgroundColor = "orangered";
	    } else if (chcolor.firstElementChild == "rgb(255, 0, 0)") {
        chcolor.style.backgroundColor = "red";
      } else if (chcolor.firstElementChild == "rgb(220, 20, 60)") {
	      chcolor.style.backgroundColor = "crimson";
	    } else if (chcolor.firstElementChild == "rgb(231, 53, 98)") {
	      chcolor.style.backgroundColor = "#e73562";
	    } else if (chcolor.firstElementChild == "rgb(255, 20, 147)") {
	      chcolor.style.backgroundColor = "deeppink";
	    } else if (chcolor.firstElementChild == "rgb(255, 105, 180)") {
	      chcolor.style.backgroundColor = "hotpink";
	    } else if (chcolor.firstElementChild == "rgb(255, 182, 193)") {
	      chcolor.style.backgroundColor = "lightpink";
	    } else if (chcolor.firstElementChild == "rgb(238, 130, 238)") {
	      chcolor.style.backgroundColor = "violet";
	    } else if (chcolor.firstElementChild == "rgb(139, 0, 139)") {
	      chcolor.style.backgroundColor = "darkmagenta";
	    } else if (chcolor.firstElementChild == "rgb(148, 0, 211)") {
	      chcolor.style.backgroundColor = "darkviolet";
	    }
    
	//}
}