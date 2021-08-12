App.thread_reaction_delete = App.cable.subscriptions.create('ThreadReactionDeleteChannel', {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var gthread_id = data['gthread_id'];
    var entity_name = data['entity_name'];
    var treaction_count_check = ( data['treaction_count_check'] >= 2 )
      ? $('#treaction_' + gthread_id + '_' + entity_name).html(data['thread_reaction'])
      : $('#treaction_' + gthread_id + '_' + entity_name).remove();
        
    treaction_count_check;
    
    $('#treaction-number' + gthread_id).html(data['treaction_count_all']);
    
    var current_user_id = data['current_user_id'];
    var thread_reaction_user_id = data['user_id'];
    
    if (current_user_id == thread_reaction_user_id) {
      $('#thread-reaction-Modal' + gthread_id).modal('hide');
    }
  }
});