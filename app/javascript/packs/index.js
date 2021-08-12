import Bound from 'bounds.js';
  
  const threadSingle = document.querySelectorAll('.thread-index-single');
  
  const boundary = Bound({
          margins: {bottom: 100}
        });
        
  threadSingle.forEach(threadSingle => {
          boundary.watch(threadSingle, onEnter)
        });