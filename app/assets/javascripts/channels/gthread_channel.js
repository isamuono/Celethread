/*document.addEventListener('turbolinks:load', function() {
  
  const thread_container = $('#thread-container');//document.getElementById("thread-container");
  
  if (thread_container === null) {
    return;
  }

  //const channel_id = data.getAttribute("data-channel_id");
  //const user_id = data.getAttribute("data-user-id");
  
  //if (!isSubscribed(channel, channel_id)) {
    App.gthread = App.cable.subscriptions.create({ channel: 'GthreadChannel', channel_id: thread_container.data('channel_id') }, {
      connected: function() {
        // Called when the subscription is ready for use on the server
      },
      disconnected: function() {
        // Called when the subscription has been terminated by the server
      },
      received: function(data) {
        var href = location.href;
        
        const threads = document.getElementById('thread-container');
        const threadTitleForm = document.getElementById('thread-new-title');
        //const threadDescriptionForm = document.getElementById('ql-editor');
        var $submit_btn = $('.thread-create-btn');
        
        var gthread_id = data['gthread_id'];
        var gthread_user_id = data['user_id'];
        //var current_user_id = data['current_user_id'];
        
        //if (href.match(`/channels/${ data['channel_id'] }/gthreads`)) {
          threads.insertAdjacentHTML('beforeend', data['gthread']);
          
          if (gon.current_user_id == gthread_user_id) {
            threadTitleForm.value = '';
            $('.ql-editor').html('<p></p>');
            $('#file_field').val(null);
            $('.image-preview, .pdf-preview').remove();
            $('.ql-editor').css('height', 100 + '%');
            $('.preview-container').css('display', 'none');
            $submit_btn.prop('disabled', true);
          }
        //}
        
        // tippy.js
        let user_image = ( data['gthread_user_images'] ) ? `<img class= "user-profile-thumbnail" src=${ data['gthread_user_images'] } >` : `<i class="far fa-user-circle"></i>`;
        let user_self_introduction = ( data['gthread_user_self_introduction'] ) ? `${ data['gthread_user_self_introduction'] }` : "";
        tippy('.thread-author-thumbnail' + gthread_id, {
          content: `<div class="tippy-user-container">
                      <div class="tippy-userbox-top">
                        <div class="tippy-user-thumbnail">
                          ${ user_image }
                        </div>
                        <div class="tippy-user-accountName">
                          ${ data['gthread_user_name'] }
                        </div>
                      </div>
                      <div class="tippy-self_introduction">${ user_self_introduction }</div>
                      <div class="tippy-userbox-bottom">
                        <div class="tippy-user-communities-count">
                          <i class="fas fa-users"></i> 所属コミュニティ数：
                          <span class="tippy-user-communities-count-number">
                            ${ data['gthread_user_communities_count'] }
                          </span>
                        </div>
                        <div class="tippy-user-created_at">
                          <i class="far fa-calendar-alt"></i>
                          ${ data['gthread_user_created_at'] }から利用しています
                        </div>
                      </div>
                    </div>`,
          allowHTML: true,
          arrow: false,
          placement: 'bottom-end',
          theme: 'light',
          delay: [600, 0],
          interactive: true
        });
        tippy('.treaction-btn', {
          content: 'リアクションする',
          theme: 'black',
          delay: [100, 0],
        });
        tippy('.treaction-number', {
          content: 'リアクションしたユーザー一覧',
          theme: 'black',
          delay: [100, 0],
        });
        tippy('.tcomment-btn', {
          content: 'コメントする',
          theme: 'black',
          delay: [100, 0],
        });
        tippy('.thread-destroy-btn', {
          content: '削除する',
          theme: 'black',
          delay: [100, 0],
        });
        
        // magnific-popup.js
        $('.image-preview' + gthread_id).magnificPopup({
          delegate: 'a',
          type: 'image',
          gallery: {
            enabled: true,
            navigateByImgClick: true,
            preload: [0, 1]
          }
        });
        
        if (gon.current_user_id == data['community_participant_id'] ) {
          // jquery-toast-plugin
          function blackOrWhite(hexcolor) {
          	var r = parseInt(hexcolor.substr( 1, 2 ), 16);
          	var g = parseInt(hexcolor.substr( 3, 2 ), 16);
          	var b = parseInt(hexcolor.substr( 5, 2 ), 16);
          
          	return ( ( ( (r * 299) + (g * 587) + (b * 114) ) / 1000 ) < 128 ) ? "white" : "black";
          }
          
          var text_color = blackOrWhite(data['channel_color']);
          
          $.toast({
            heading: `${ data['channel_name'] } チャンネル`,
            text: 'スレッドが投稿されました',
            position: 'top-right',
            bgColor: `${ data['channel_color'] }`,
            textColor: text_color,
            loader: false,
            hideAfter: 20000,//false,
            showHideTransition: 'fade',
            stack: 4
          });
        }
        
        // 削除時確認ダイアログ(sweetalert2)
        $('#thread-destroy-btn' + gthread_id).on('click', function(e) {
          e.preventDefault();
          e.stopPropagation();
          
          // ダイアログを閉じてもボタンがフォーカス状態でtippyが動作してしまうため
          $('.thread-destroy-btn').blur();
        
          var $link = $(this);
        
          swal.fire({
            icon: 'warning',
            iconColor: 'red',
            title: `${ data['title'] } を削除してもよろしいですか？`,
            text: 'このスレッドのリアクション、コメントは全て削除されます。本当によろしいですか？',
            confirmButtonText: '削除する',
            confirmButtonColor: '#d33',
            showCancelButton: true,
            cancelButtonText: 'キャンセル',
            focusCancel: true,
            position : 'center',
            allowEscapeKey: true, //escボタン
            customClass: {
              popup: 'sweetalert-thread-destroy'
            }
          }).then(function(result) {
            if (result.isConfirmed) {
              $link.trigger('click.rails');
            }
          }, function(dismiss) {});
        });
      }
    });
  //}
  
  //const isSubscribed = function(channel, channel_id) {
    //const identifier = `{'channel': '${ channel }', 'channel_id': '${ channel_id }'}`;
    //const subscription = App.cable.subscriptions.findAll(identifier);
    //return !!subscription.length;
  //};
});*/