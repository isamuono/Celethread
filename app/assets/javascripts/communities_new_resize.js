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
window.addEventListener('load', categorySet());
window.addEventListener('load', resizeElement());

function resizeElement() {
  const windowWidth = document.documentElement.clientWidth;
  
  const resizebox1 = document.getElementById('communityName');
    if (windowWidth <= 767) {
      resizebox1.className = 'form-control';
    } else if (windowWidth >= 768) {
      resizebox1.className = 'form-control form-control-lg';
    } 
  const resizeCustomselectbox1 = document.getElementById('categorySelect');
    if (windowWidth <= 767) {
      resizeCustomselectbox1.className = 'custom-select text-charcoal';
    } else if (windowWidth >= 768) {
      resizeCustomselectbox1.className = 'custom-select custom-select-lg text-charcoal';
    } 
  const resizeCustomselectbox2 = document.getElementById('subcategorySelect');
    if (windowWidth <= 767) {
      resizeCustomselectbox2.className = 'custom-select text-charcoal';
    } else if (windowWidth >= 768) {
      resizeCustomselectbox2.className = 'custom-select custom-select-lg text-charcoal';
    } 
  const resizeCustomselectbox3 = document.getElementById('prefectureSelect');
    if (windowWidth <= 767) {
      resizeCustomselectbox3.className = 'custom-select text-charcoal';
    } else if (windowWidth >= 768) {
      resizeCustomselectbox3.className = 'custom-select custom-select-lg text-charcoal';
    } 
}

window.orientationchange = function() {
  if (Math.abs(window.orientation) === 0) {
    window.reload(); 
  } else {
    window.reload();
  }
};

var subcategories;

function categorySet() {
  var value = document.getElementById('categorySelect').value;
  var subcateSel = document.getElementById('subcategorySelect');
  var i;
  
  if (1 <= value && value <= 4) {
    document.getElementById('form-group').style.display = 'block';
    
    var subs = subcategories[value];
    var size = subcateSel.options.length;
    
    for (i = 0; i < size; i++) {
      subcateSel.remove(0);
    }
    
    for (i = 0; i < subs.length; i++) {
      var option = document.createElement('option');
        option.text = subs[i];
        option.value = i;
        subcateSel.add(option);
    }
  } else {
    document.getElementById('form-group').style.display = 'none';
  }
  
  subcateSel.selectedIndex = 0;
}