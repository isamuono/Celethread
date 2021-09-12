App.thread_reaction = App.cable.subscriptions.create('ThreadReactionChannel', {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var href = location.href;
    
    var thread_reaction_user_id = data['user_id'];
    var gthread_id = data['gthread_id'];
    var entity_name = data['entity_name'];
    var images = data['images'];
    var treaction_user_accountName = data['treaction_user_accountName'];
    
    if (href.match(`/channels/${ data['channel_id'] }/gthreads`)) {
      var thread_reaction_already_present_check = data['thread_reaction_already_present_check'];
      var treaction_user_ids = data['treaction_user_ids'];
      
      if (gon.current_user_id == thread_reaction_user_id && thread_reaction_already_present_check == false) {
        document.getElementById('treactions-list-container' + gthread_id).insertAdjacentHTML('beforeend', data['my_treaction']);
        
        $('#thread-reaction-Modal' + gthread_id).modal('hide');
        
        tippy('.treactions-list_' + gthread_id + '_' + entity_name, {
          content: `<div class="tippy-treaction-users-container">
                      <div class="tippy-treaction-images-box">
                        <img src=${ images } class="tippy-treaction-images">
                      </div>
                      <div class="tippy-treaction-users-accountName">
                        ${ treaction_user_accountName }さんが
                        <span class="tippy-treaction-text-attached">リアクションしました</span>
                        （削除する場合はクリック）
                      </div>
                    </div>`,
          allowHTML: true,
          theme: 'treaction',
          delay: [200, 0]
        });
        
        // 削除時確認ダイアログ(sweetalert2)
        $('#reaction-destroy-btn_' + gthread_id + '_' + entity_name).on('click', function(e) {
          e.preventDefault();
          e.stopPropagation();
          
          $('.treactions-list_' + gthread_id + '_' + entity_name).blur();
        
          var $link = $(this);
        
          swal.fire({
            icon: 'warning',
            iconColor: 'red',
            title: 'このリアクションを削除してもよろしいですか？',
            confirmButtonText: '削除する',
            confirmButtonColor: '#d33',
            showCancelButton: true,
            cancelButtonText: 'キャンセル',
            focusCancel: true,
            position : 'center',
            allowEscapeKey: true,
            customClass: {
              popup: 'sweetalert-reaction-destroy'
            }
          }).then(function(result) {
            if (result.isConfirmed) {
              $.ajax({
                url: '/thread_reactions/' + entity_name,
                type: 'DELETE',
                data: { gthread_id: gthread_id },
              });
            }
          }, function(dismiss) {});
        });
      } else if (gon.current_user_id == thread_reaction_user_id && thread_reaction_already_present_check) {
        $('#treaction_' + gthread_id + '_' + entity_name).html(data['my_treaction']);
        
        $('#thread-reaction-Modal' + gthread_id).modal('hide');
      } else if (gon.current_user_id != thread_reaction_user_id && thread_reaction_already_present_check == false) {
        document.getElementById('treactions-list-container' + gthread_id).insertAdjacentHTML('beforeend', data['others_treaction']);
        
        tippy('.treactions-list_' + gthread_id + '_' + entity_name, {
          content: `<div class="tippy-treaction-users-container">
                      <div class="tippy-treaction-images-box">
                        <img src=${ images } class="tippy-treaction-images">
                      </div>
                      <div class="tippy-treaction-users-accountName">
                        ${ treaction_user_accountName }さんが
                        <span class="tippy-treaction-text-attached">リアクションしました</span>
                      </div>
                    </div>`,
          allowHTML: true,
          theme: 'treaction',
          delay: [200, 0]
        });
      } else if (gon.current_user_id != thread_reaction_user_id && thread_reaction_already_present_check) {
        if (treaction_user_ids.includes(gon.current_user_id))
          $('#treaction_' + gthread_id + '_' + entity_name).html(data['my_treaction']);
        else
          $('#treaction_' + gthread_id + '_' + entity_name).html(data['others_treaction']);
      }
      
      $('#treaction-number' + gthread_id).html(data['treaction_count_all']);
    }
  }
});