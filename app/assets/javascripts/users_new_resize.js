var resizeFlg;    //setTimeoutの待機中かを判定するフラグ

function windowResizeFunc(){

  //resizeFlgに値が設定されている場合は、待ち時間中なのでリセットする
  if (resizeFlg !== false) {
      clearTimeout(resizeFlg);
  }
  //300ms待機後にリサイズ処理を実施する
  resizeFlg = setTimeout( function() {
      resizeElement();    //リサイズを実施する処理
  }, 300);
}
window.addEventListener("resize", windowResizeFunc);
window.addEventListener('load', resizeElement());

function resizeElement(){
  const windowWidth = document.documentElement.clientWidth;
  const windowHeight = document.documentElement.clientHeight;

  const resizebox1 = document.getElementById("family_name");
    if (windowWidth <= 592) {
      resizebox1.className = "form-control form-control-sm";
    } else if (593 <= windowWidth <= 699) {
      resizebox1.className = "form-control";
    } else if (windowWidth >= 667) {
      resizebox1.className = "form-control form-control-lg";
    }
  const resizebox2 = document.getElementById("first_name");
    if (windowWidth <= 570) {
      resizebox2.className = "form-control form-control-sm";
    } else if (windowWidth >= 667) {
      resizebox2.className = "form-control form-control-lg";
    }
  const resizebox3 = document.getElementById("accountName");
    if (windowWidth <= 570) {
      resizebox3.className = "form-control form-control-sm";
    } else if (windowWidth >= 667) {
      resizebox3.className = "form-control form-control-lg";
    }
  const resizebox4 = document.getElementById("email");
    if (windowWidth <= 570) {
      resizebox4.className = "form-control form-control-sm";
    } else if (windowWidth >= 667) {
      resizebox4.className = "form-control form-control-lg";
    }
  const resizebox5 = document.getElementById("password");
    if (windowWidth <= 570) {
      resizebox5.className = "form-control form-control-sm";
    } else if (windowWidth >= 667) {
      resizebox5.className = "form-control form-control-lg";
    }
  const resizebox6 = document.getElementById("password_confirmation");
    if (windowWidth <= 570) {
      resizebox6.className = "form-control form-control-sm";
    } else if (windowWidth >= 667) {
      resizebox6.className = "form-control form-control-lg";
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