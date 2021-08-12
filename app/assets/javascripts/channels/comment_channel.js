/*App.comment = App.cable.subscriptions.create('CommentChannel', {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },
  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },
  received: function(data) {
    const comments = document.getElementById('comment<%= @thread_comment.id %>');
    const newComment = document.getElementById('commentTextForm<%= @thread_comment.id %>');
    comments.insertAdjacentHTML('beforeend', data['comment']);
    newComment.value='';
  }
});*/
// コメントフォーム
  /*var $submit_btn = $('#submit');
  var $text_field = document.getElementById('commentTextForm');
  
  $submit_btn.prop('disabled', true);
  
  //var lineHeight = parseInt($text_field.css('lineHeight'));
  // 最低行数を指定
  //var minHeight = lineHeight * 1;
  const maxLineCount = 13;
  // 最高幅を指定
  var maxHeight = parseInt($(window).height() * 0.45);
    
  $text_field.addEventListener('input', function() {
    //未入力の場合送信ボタン使用不可
    var $text_count = $text_field.value.length;
    var $text_val = $text_field.value;
    
    if ($text_count >= 1 && !$text_val.match(/\S/g) == '') {
      $submit_btn.prop('disabled', false);
    } else {
      $submit_btn.prop('disabled', true);
    }
    
    // 上方向に拡大
    //var lines = ($(this).value + '\n').match(/\n/g).length;
    changeLineCheck();
    
    //$(this).height(Math.min(maxHeight, Math.max(lineHeight * lines, minHeight)));
  });
  
  const getLineCount = function() {
    return ($text_field.value + '\n').match(/\r?\n/g).length;
  };

  let lineCount = getLineCount();
  let newlineCount;
  
  const changeLineCheck = function() {
    // 現在の入力行数を取得（ただし，最大の行数は maxLineCount とする）
    newlineCount = Math.min(getLineCount(), maxLineCount);
    // 以前の入力行数と異なる場合は変更する
    if (lineCount !== newlineCount) {
      changelineCount(newlineCount);
    }
  };
  
  const comments = document.getElementById('comment');
  const footer = document.getElementById('modal-footer');
  let footerHeight = $text_field.scrollHeight;
  let newfooterHeight,
      footerHeightDiff;
      
  //var paddingBottom = parseInt($('#comments').css('padding-bottom'));
  
  /*$('.tcomment-textarea').on('input', function(){
    const maxLineHeight = 13;
    let lineHeight = Number($text_field.getAttribute('rows'));
    
    if ($(this).outerHeight() > this.scrollHeight && lineHeight < maxLineHeight){
      $(this).height(1)
    }
    while ($(this).outerHeight() < this.scrollHeight && lineHeight < maxLineHeight){
      $(this).height($(this).height() + 1)
    }
  });*/
  
  /*$text_field.addEventListener('input', changelineCount = (newlineCount) => {
    $text_field.rows = lineCount;
    lineCount = newlineCount;
    
    // 文字量によって自動で高さが変わるtextarea
    $('.tcomment-textarea').height(0).innerHeight($text_field.scrollHeight);
    
    newfooterHeight = $text_field.scrollHeight;
    footerHeightDiff = newfooterHeight - footerHeight;
    if (footerHeightDiff > 0/* && newlineCount <= 4*///) {
      //comments.style.paddingBottom = newfooterHeight - 40 + 'px';
/*      comments.style.height = 501 - newfooterHeight + 40 + 'px';
      comments.scrollBy(0, footerHeightDiff);
    } else {
      comments.scrollBy(0, footerHeightDiff);
      //comments.style.paddingBottom = newfooterHeight - 40 + 'px';
      comments.style.height = 501 - newfooterHeight + 40 + 'px';
    }
    footerHeight = newfooterHeight;
  });
  
  //const data = document.getElementById('data')
  //const thread_id = data.getAttribute('data-thread-id');*/
  //const comment_modal = $('#tcomment-Modal');
  
  // コメント数の増加のみ常に購読状態にする
  App.comment = App.cable.subscriptions.create('CommentChannel', {
    connected: function() {
      // Called when the subscription is ready for use on the server
    },
    disconnected: function() {
      // Called when the subscription has been terminated by the server
    },
    received: function(data) {
      var gthread_id = data['gthread_id'];
      $('#tcomment-number' + gthread_id).html(data['tcomment_count']);
    }
  });