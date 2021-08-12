/*$(function() {
  $('.thread-destroy-btn-a').on('click', function () {
    var deleteConfirm = confirm('削除してよろしいでしょうか？');
    if (deleteConfirm == true) {
      var thread_element = $(this).parents().parents('.thread-index-single');
      var thread_id = thread_element.attr("data-id");
      var url = '/gthreads/' + thread_id;

      $.ajax({
        url: url,
        type: 'POST',
        data: { 'id': thread_id, '_method': 'DELETE', remote: true }
      })
      .done(function(data) {
        thread_element.remove();
      })
  
      .fail(function() {
        alert('スレッドの削除に失敗しました');
      });
    }
  });
});*/