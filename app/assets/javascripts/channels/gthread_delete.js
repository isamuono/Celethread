App.gthread_delete = App.cable.subscriptions.create('GthreadDeleteChannel', {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },
  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },
  
  //delete: function(id) {
  //  return this.perform('delete', {
  //    id: id
  //  });
  //},
  
  //function() {
  //  $('.thread-destroy-btn-a').on('click', function(event) {
  //    return App["delete"]["delete"](event.target.id);
  //  });
  //},
  
  received: function(data) {
    var gthread_id = data['gthread_id'];
    var thread_destroied_text = `<span class="thread-destroied-text">スレッドは削除されました</span>`;
    
    $("#thread" + gthread_id).html(thread_destroied_text);
    //$("#thread" + gthread_id).remove();
  }
});