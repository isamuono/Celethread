var resizeFlg;

function windowResizeFunc(){
  if (resizeFlg !== false) {
      clearTimeout(resizeFlg);
  }
  resizeFlg = setTimeout( function() {
      resizeElement();
  }, 300);
}

window.addEventListener("resize", windowResizeFunc);
window.addEventListener('load', resizeElement());

function resizeElement(){
  const windowWidth = document.documentElement.clientWidth;
  //const windowHeight = document.documentElement.clientHeight;

  const resizebox1 = document.getElementById("email");
    if (windowWidth <= 767) {
      resizebox1.className = "form-control";
    } else if (windowWidth >= 768) {
      resizebox1.className = "form-control form-control-lg";
    }
}

//傾きを変える度に現在の傾きを判定
window.orientationchange = function (){
  if (Math.abs(window.orientation) === 0){
    window.reload(); 
  } else {
    window.reload();
  }
};
