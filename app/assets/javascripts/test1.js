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

const windowWidth = document.documentElement.clientWidth;
const windowHeight = document.documentElement.clientHeight;

//要素を取得してから、幅と高さを取得
let stable1 = document.getElementById("stable1");
const stable1Width = stable1[0].getBoundingClientRect().width;
const stable1Height = stable1[0].getBoundingClientRect().height;

//メソッドチェーンで要素の幅と高さを取得
let stable2Width= document.getElementById("stable2")[0]
                          .getBoundingClientRect().width;
let stable2Height= document.getElementById("stable2")[0]
                          .getBoundingClientRect().height;

let active= document.getElementById("active");

active.style.width = ( windowWidth - stable1Width - stable2Width ) + "px";
active.style.height = ( windowHeight - stable1Height - stable2Height ) + "px";
