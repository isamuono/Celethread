App.thread_reaction_delete = App.cable.subscriptions.create('ThreadReactionDeleteChannel', {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var thread_reaction_user_id = data['user_id'];
    var gthread_id = data['gthread_id'];
    var entity_name = data['entity_name'];
    
    var treaction_count = data['treaction_count'];
    var treaction_user_ids = data['treaction_user_ids'];
    
    if (gon.current_user_id == thread_reaction_user_id && treaction_count == 1) {
      $('#treaction_' + gthread_id + '_' + entity_name).remove();
      
      $('#thread-reaction-Modal' + gthread_id).modal('hide');
    } else if (gon.current_user_id == thread_reaction_user_id && treaction_count >= 2) {
      $('#treaction_' + gthread_id + '_' + entity_name).html(data['others_treaction']);
      
      $('#thread-reaction-Modal' + gthread_id).modal('hide');
    } else if (gon.current_user_id != thread_reaction_user_id && treaction_count == 1) {
      $('#treaction_' + gthread_id + '_' + entity_name).remove();
    } else if (gon.current_user_id != thread_reaction_user_id && treaction_count >= 2) {
      if (treaction_user_ids.includes(gon.current_user_id))
        $('#treaction_' + gthread_id + '_' + entity_name).html(data['my_treaction']);
      else
        $('#treaction_' + gthread_id + '_' + entity_name).html(data['others_treaction']);
    }
    
    $('#treaction-number' + gthread_id).html(data['treaction_count_all']);
  }
});