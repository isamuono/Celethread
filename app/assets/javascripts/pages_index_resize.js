var resizeFlg;

function windowResizeFunc() {
  if (resizeFlg !== false) {
    clearTimeout(resizeFlg);
  }
  
  resizeFlg = setTimeout(function() {
    resizeElement();
  }, 300);
}

window.addEventListener('resize', windowResizeFunc);
window.addEventListener('load', resizeElement());

function resizeElement() {
  const windowWidth = document.documentElement.clientWidth;
  
  const resizebox = document.getElementById('resizebox');
    if (windowWidth <= 767) {
      resizebox.className = 'form-control';
    } else if (windowWidth >= 768) {
      resizebox.className = 'form-control form-control-lg';
    }
  //Viewportサイズが414px（iPhone 5 系列）の時、
  //サインアップ/ログインボタンのカラム変更
  const resizebutton1 = document.getElementById('resizebutton1');
    if (windowWidth <= 414) {
      resizebutton1.className = 'offset-1 col-5';
    } else if (415 <= windowWidth && windowWidth <= 736) {
      resizebutton1.className = 'offset-1 col-4';
    }
  const resizebutton2 = document.getElementById('resizebutton2');
    if (windowWidth <= 414) {
      resizebutton2.className = 'col-5';
    } else if (415 <= windowWidth && windowWidth <= 736) {
      resizebutton2.className = 'offset-2 col-4';
    }
}

window.orientationchange = function() {
  if (Math.abs(window.orientation) === 0) {
    window.reload(); 
  } else {
    window.reload();
  }
};