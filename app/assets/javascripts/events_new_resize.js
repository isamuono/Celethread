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
window.addEventListener('load', dateRangeSet());
window.addEventListener('load', timeRangeSet());
window.addEventListener('load', resizeElement());

function resizeElement() {
  const windowWidth = document.documentElement.clientWidth;
  
  const resizebox1 = document.getElementById('form1');
    if (windowWidth <= 767) {
      resizebox1.className = 'form-control';
    } else if (windowWidth >= 768) {
      resizebox1.className = 'form-control form-control-lg';
    } 
  const resizebox2 = document.getElementById('form2');
    if (windowWidth <= 767) {
      resizebox2.className = 'form-control flatpickr1';
    } else if (windowWidth >= 768) {
      resizebox2.className = 'form-control form-control-lg flatpickr1';
    } 
  const resizebox3 = document.getElementById('form3');
    if (windowWidth <= 767) {
      resizebox3.className = 'form-control timepicker time start';
    } else if (windowWidth >= 768) {
      resizebox3.className = 'form-control form-control-lg timepicker time start';
    } 
  const resizebox4 = document.getElementById('form4');
    if (windowWidth <= 767) {
      resizebox4.className = 'form-control timepicker time end';
    } else if (windowWidth >= 768) {
      resizebox4.className = 'form-control form-control-lg timepicker time end';
    } 
  const resizebox5 = document.getElementById('form5');
    if (windowWidth <= 767) {
      resizebox5.className = 'form-control flatpickr2';
    } else if (windowWidth >= 768) {
      resizebox5.className = 'form-control form-control-lg flatpickr2';
    } 
  const resizebox6 = document.getElementById('form6');
    if (windowWidth <= 767) {
      resizebox6.className = 'form-control timepicker';
    } else if (windowWidth >= 768) {
      resizebox6.className = 'form-control form-control-lg timepicker';
    } 
  const resizebox7 = document.getElementById('secondRangeInput');
    if (windowWidth <= 767) {
      resizebox7.className = 'form-control flatpickr2';
    } else if (windowWidth >= 768) {
      resizebox7.className = 'form-control form-control-lg flatpickr2';
    } 
  const resizebox8 = document.getElementById('form8');
    if (windowWidth <= 767) {
      resizebox8.className = 'form-control timepicker';
    } else if (windowWidth >= 768) {
      resizebox8.className = 'form-control form-control-lg timepicker';
    } 
  const resizebox9 = document.getElementById('form9');
    if (windowWidth <= 767) {
      resizebox9.className = 'form-control';
    } else if (windowWidth >= 768) {
      resizebox9.className = 'form-control form-control-lg';
    } 
}

window.orientationchange = function() {
  if (Math.abs(window.orientation) === 0) {
    window.reload(); 
  } else {
    window.reload();
  }
};

function dateRangeSet() {
  const value1 = document.getElementById('daterange-checkbox').checked;
  const value2 = document.getElementById('allday-checkbox').checked;
  
  const slideCheckbox = document.getElementById('slidecheckbox');
  const slideForm = document.getElementById('enddate');
  
  if (value1 == false && value2 == true) {
    document.getElementById('datepair').style.display = 'block';
    document.getElementById('normal-flatpickr').style.display = 'block';
    document.getElementById('starttime1').style.display = 'none';
    document.getElementById('from-to1').style.display = 'none';
    document.getElementById('endtime1').style.display = 'none';
    
    document.getElementById('range-flatpickr').style.display = 'none';
    document.getElementById('starttime2').style.display = 'none';
    document.getElementById('from-to2').style.display = 'none';
    document.getElementById('enddate').style.display = 'none';
    document.getElementById('endtime2').style.display = 'none';
  } else if (value1 == false && value2 == false) {
    document.getElementById('datepair').style.display = 'block';
    document.getElementById('normal-flatpickr').style.display = 'block';
    document.getElementById('starttime1').style.display = 'block';
    document.getElementById('from-to1').style.display = 'block';
    document.getElementById('endtime1').style.display = 'block';
    
    document.getElementById('range-flatpickr').style.display = 'none';
    document.getElementById('starttime2').style.display = 'none';
    document.getElementById('from-to2').style.display = 'none';
    document.getElementById('enddate').style.display = 'none';
    document.getElementById('endtime2').style.display = 'none';
    
    slideCheckbox.className = 'col-4';
  } else if (value1 == true && value2 == true) {
    document.getElementById('datepair').style.display = 'none';
    
    document.getElementById('range-flatpickr').style.display = 'block';
    document.getElementById('starttime2').style.display = 'none';
    document.getElementById('from-to2').style.display = 'block';
    document.getElementById('enddate').style.display = 'block';
    document.getElementById('endtime2').style.display = 'none';
    
    slideForm.className = 'col-5';
    slideCheckbox.className = 'col-4';
  } else if (value1 == true && value2 == false) { //日付範囲on, 終日off
    document.getElementById('datepair').style.display = 'none';
    
    document.getElementById('range-flatpickr').style.display = 'block';
    document.getElementById('starttime2').style.display = 'block';
    document.getElementById('from-to2').style.display = 'block';
    document.getElementById('enddate').style.display = 'block';
    document.getElementById('endtime2').style.display = 'block';
    
    slideForm.className = 'offset-4 col-5';
    slideCheckbox.className = 'col-4 upslide';
  }
}

function timeRangeSet() {
  const value1 = document.getElementById('daterange-checkbox').checked;
  const value2 = document.getElementById('allday-checkbox').checked;
  
  const slideCheckbox = document.getElementById('slidecheckbox');
  const slideForm = document.getElementById('enddate');
  if (value1 == false && value2 == true) {
    document.getElementById('normal-flatpickr').style.display = 'block';
    document.getElementById('starttime1').style.display = 'none';
    document.getElementById('from-to1').style.display = 'none';
    document.getElementById('endtime1').style.display = 'none';
    
    document.getElementById('range-flatpickr').style.display = 'none';
    document.getElementById('starttime2').style.display = 'none';
    document.getElementById('from-to2').style.display = 'none';
    document.getElementById('enddate').style.display = 'none';
    document.getElementById('endtime2').style.display = 'none';
  } else if (value1 == false && value2 == false) {
    document.getElementById('normal-flatpickr').style.display = 'block';
    document.getElementById('starttime1').style.display = 'block';
    document.getElementById('from-to1').style.display = 'block';
    document.getElementById('endtime1').style.display = 'block';
    
    document.getElementById('range-flatpickr').style.display = 'none';
    document.getElementById('starttime2').style.display = 'none';
    document.getElementById('from-to2').style.display = 'none';
    document.getElementById('enddate').style.display = 'none';
    document.getElementById('endtime2').style.display = 'none';
  } else if (value1 == true && value2 == true) {
    document.getElementById('datepair').style.display = 'none';
    
    document.getElementById('range-flatpickr').style.display = 'block';
    document.getElementById('starttime2').style.display = 'none';
    document.getElementById('from-to2').style.display = 'block';
    document.getElementById('enddate').style.display = 'block';
    document.getElementById('endtime2').style.display = 'none';
    
    slideForm.className = 'col-5';
    slideCheckbox.className = 'col-4';
  } else if (value1 == true && value2 == false) { //日付範囲on, 終日off
    document.getElementById('datepair').style.display = 'none';
    
    document.getElementById('range-flatpickr').style.display = 'block';
    document.getElementById('starttime2').style.display = 'block';
    document.getElementById('from-to2').style.display = 'block';
    document.getElementById('enddate').style.display = 'block';
    document.getElementById('endtime2').style.display = 'block';
    
    slideForm.className = 'offset-4 col-5';
    slideCheckbox.className = 'col-4 upslide';
  }
}