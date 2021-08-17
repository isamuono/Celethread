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
  
  const resizebox1 = document.getElementById('channelName');
    if (windowWidth <= 767) {
      resizebox1.className = 'form-control';
    } else if (windowWidth >= 768) {
      resizebox1.className = 'form-control form-control-lg';
    }
  const resizebox2 = document.getElementById('description');
    if (windowWidth <= 767) {
      resizebox2.className = 'form-control';
    } else if (windowWidth >= 768) {
      resizebox2.className = 'form-control form-control-lg';
    }
}

window.orientationchange = function() {
  if (Math.abs(window.orientation) === 0) {
    window.reload(); 
  } else {
    window.reload();
  }
};