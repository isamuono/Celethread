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

  const resizebox = document.getElementById("resizebox");
    if (windowWidth <= 767) {
      resizebox.className = "form-control";
    } else if (windowWidth >= 768) {
      resizebox.className = "form-control form-control-lg";
    }
  
  //Viewportサイズが414px（iPhone 5 系列）の時、
  //サインアップ/ログインボタンのカラム変更
  const resizebutton1 = document.getElementById("resizebutton1");
    if (windowWidth <= 414) {
      resizebutton1.className = "offset-1 col-5";
    } else if (415 <= windowWidth && windowWidth <= 736) {
      resizebutton1.className = "offset-1 col-4";
    }
    
  const resizebutton2 = document.getElementById("resizebutton2");
    if (windowWidth <= 414) {
      resizebutton2.className = "col-5";
    } else if (415 <= windowWidth && windowWidth <= 736) {
      resizebutton2.className = "offset-2 col-4";
    }
}

//デバイスの向きをalert表示  
//var orient = window.onorientation;
//  if(Math.abs(window.orientation) === 0){
//    alert("横向き");
//  } else {
//    alert("縦向き");
//  } 
  
//傾きを変える度に現在の傾きを判定
window.orientationchange = function (){
  if (Math.abs(window.orientation) === 0){
    window.reload(); 
  } else {
    window.reload();
  }
};