App.comment_delete = App.cable.subscriptions.create('CommentDeleteChannel', {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },
  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },
  
  received: function(data) {
    var comment_id = data['comment_id'];
    var gthread_id = data['gthread_id'];
    var comment_destroied_text = `<p class="comment-destroied-text">コメントは削除されました</p>`;
    
    $('#comment' + comment_id).html(comment_destroied_text);
    //$('#comment' + comment_id).remove();
    $('#tcomment-number' + gthread_id).html(data['tcomment_count']);
  }
});