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

  const resizebox1 = document.getElementById("text");
    if (windowWidth <= 767) {
      resizebox1.className = "form-control";
    } else if (windowWidth >= 768) {
      resizebox1.className = "form-control form-control-lg";
    }
  const resizebox2 = document.getElementById("password");
    if (windowWidth <= 767) {
      resizebox2.className = "form-control";
    } else if (windowWidth >= 768) {
      resizebox2.className = "form-control form-control-lg";
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

// Bootstrap バリデーションチェック
(function() {
  'use strict';
  window.addEventListener('load', function() {
    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.getElementsByClassName('needs-validation');
    // Loop over them and prevent submission
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  }, false);
})();