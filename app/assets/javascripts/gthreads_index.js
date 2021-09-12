window.addEventListener('load', colorElement());
window.addEventListener('load', openNav());
window.addEventListener('load', closeNav());

/* Sidenav Overlay */
function openNav() {
  document.getElementById('mySidenav').style.width = '250px';
  document.getElementById('menu-contents').style.width = '250px';
}

function closeNav() {
  document.getElementById('mySidenav').style.width = '0';
  document.getElementById('menu-contents').style.width = '0';
}

/* Dropdown List  */
var dropdown = document.getElementsByClassName('community-name');
var i;

for (i = 0; i < dropdown.length; i++) {
  dropdown[i].addEventListener('click', function() {
    var parent_element = this.parentElement;
    var dropdownContainer = parent_element.nextElementSibling; // 隣接する兄弟要素のdivタグを取得
    
    if (dropdownContainer.style.display === 'block') {
      dropdownContainer.style.display = 'none';
    } else {
      dropdownContainer.style.display = 'block';
    }
  });
}

var deepdropdown = document.getElementsByClassName('deep-dropdown-btn');

for (i = 0; i < deepdropdown.length; i++) {
  deepdropdown[i].addEventListener('click', function() {
    var deepdropdownContainer = this.nextElementSibling;
    if (deepdropdownContainer.style.display === 'block') {
      deepdropdownContainer.style.display = 'none';
    } else {
      deepdropdownContainer.style.display = 'block';
    }
  });
}

// スレッド作成 アコーディオン
var new_thread_btn = document.getElementById('new-thread-btn');

new_thread_btn.onclick = function() {
  if ($('.footer_container').css('display') == 'none') {
    $('.footer_container').slideDown();
    $('.overlay_container').toggleClass('overlay');
  }
};

if (gon.channel_id == 'celestebot') { 
  $('#new-thread-btn').prop('disabled', true);
} else {
  $('#new-thread-btn').prop('disabled', false);
}

// チャンネル切替時のNavbarのチャンネルイメージカラーの変更
document.addEventListener('turbolinks:load', function() {
  let mutationObserver = new MutationObserver(function() {
    color_icon.style.backgroundColor = `${ hex.innerHTML }`;
  });
  
  const color_icon = document.getElementById('color-icon');
  const hex = document.getElementById('hex');
  
  const config = { 
    attributes: true, 
    childList: true, 
    characterData: true,
    subtree: true
  };
  
  mutationObserver.observe(color_icon, config);
});

// サイドメニュー チャンネルイメージカラー
function colorElement() {
  const color = $('#color-icon, .color-icons, .channel-color');
  const color_arr = Array.from(color);
  
  //for ( i = 0; i < color.length; i++ ) {
	  //const color = document.querySelector('.color-icon');
	  const forEach_arr = color_arr.forEach(function(value) {
	    if (value.firstElementChild.innerHTML == '#000000') {
	      value.style.backgroundColor = 'black';
	    } else if (value.firstElementChild.innerHTML == '#808080') {
	      value.style.backgroundColor = 'gray';
	    } else if (value.firstElementChild.innerHTML == '#4682b4') {
	      value.style.backgroundColor = 'steelblue';
	    } else if (value.firstElementChild.innerHTML == '#000080') {
	      value.style.backgroundColor = 'navy';
	    } else if (value.firstElementChild.innerHTML == '#0000ff') {
	      value.style.backgroundColor = 'blue';
	    } else if (value.firstElementChild.innerHTML == '#4169e1') {
	      value.style.backgroundColor = 'royalblue';
	    } else if (value.firstElementChild.innerHTML == '#1e90ff') {
	      value.style.backgroundColor = 'dodgerblue';
	    } else if (value.firstElementChild.innerHTML == '#00bfff') {
	      value.style.backgroundColor = 'deepskyblue';
	    } else if (value.firstElementChild.innerHTML == '#87cefa') {
	      value.style.backgroundColor = 'lightskyblue';
	    } else if (value.firstElementChild.innerHTML == '00ffff') {
	      value.style.backgroundColor = 'cyan';
	    } else if (value.firstElementChild.innerHTML == '#00afcc') {
	      value.style.backgroundColor = '#00afcc'; // turquoise blue
	    } else if (value.firstElementChild.innerHTML == '#008b8b') {
	      value.style.backgroundColor = 'darkcyan';
	    } else if (value.firstElementChild.innerHTML == '#008000') {
	      value.style.backgroundColor = 'green';
	    } else if (value.firstElementChild.innerHTML == '#3cb371') {
	      value.style.backgroundColor = 'mediumseagreen';
	    } else if (value.firstElementChild.innerHTML == '#98fb98') {
	      value.style.backgroundColor = 'palegreen';
	    } else if (value.firstElementChild.innerHTML == '#adff2f') {
        value.style.backgroundColor = 'greenyellow';
      } else if (value.firstElementChild.innerHTML == '#00ff00') {
        value.style.backgroundColor = 'lime';
      } else if (value.firstElementChild.innerHTML == '#9fc24d') {
        value.style.backgroundColor = '#9fc24d'; // leaf green
      } else if (value.firstElementChild.innerHTML == '#9acd32') {
	      value.style.backgroundColor = 'yellowgreen';
	    } else if (value.firstElementChild.innerHTML == '#d9e367') {
	      value.style.backgroundColor = '#d9e367'; //chartreuse green
	    } else if (value.firstElementChild.innerHTML == '#bdb76b') {
	      value.style.backgroundColor = 'darkkhaki';
	    } else if (value.firstElementChild.innerHTML == '#f0e68c') {
	      value.style.backgroundColor = 'khaki';
	    } else if (value.firstElementChild.innerHTML == '#fff799') {
	      value.style.backgroundColor = '#fff799'; //limelight
	    } else if (value.firstElementChild.innerHTML == '#fff352') {
	      value.style.backgroundColor = '#fff352'; //lemon yellow
	    } else if (value.firstElementChild.innerHTML == '#ffdc00') {
	      value.style.backgroundColor = '#ffdc00'; //yellow(jaune brillant)
	    } else if (value.firstElementChild.innerHTML == '#fcc800') {
	      value.style.backgroundColor = '#fcc800'; //chrome yellow
	    } else if (value.firstElementChild.innerHTML == '#ffa500') {
	      value.style.backgroundColor = 'orange';
	    } else if (value.firstElementChild.innerHTML == '#ff8c00') {
	      value.style.backgroundColor = 'darkorange';
	    } else if (value.firstElementChild.innerHTML == '#8f6552') {
	      value.style.backgroundColor = '#8f6552';
	    } else if (value.firstElementChild.innerHTML == '#8b4513') {
	      value.style.backgroundColor = 'saddlebrown';
	    } else if (value.firstElementChild.innerHTML == '#b22222') {
	      value.style.backgroundColor = 'firebrick';
	    } else if (value.firstElementChild.innerHTML == '#ff6347') {
	      value.style.backgroundColor = 'tomato';
	    } else if (value.firstElementChild.innerHTML == '#ff4500') {
	      value.style.backgroundColor = 'orangered';
	    } else if (value.firstElementChild.innerHTML == '#ff0000') {
        value.style.backgroundColor = 'red';
      } else if (value.firstElementChild.innerHTML == '#dc143c') {
	      value.style.backgroundColor = 'crimson';
	    } else if (value.firstElementChild.innerHTML == '#e73562') {
	      value.style.backgroundColor = '#e73562';
	    } else if (value.firstElementChild.innerHTML == '#ff1493') {
	      value.style.backgroundColor = 'deeppink';
	    } else if (value.firstElementChild.innerHTML == '#ff69b4') {
	      value.style.backgroundColor = 'hotpink';
	    } else if (value.firstElementChild.innerHTML == '#ffb6c1') {
	      value.style.backgroundColor = 'lightpink';
	    } else if (value.firstElementChild.innerHTML == '#ee82ee') {
	      value.style.backgroundColor = 'violet';
	    } else if (value.firstElementChild.innerHTML == '#8b008b') {
	      value.style.backgroundColor = 'darkmagenta';
	    } else if (value.firstElementChild.innerHTML == '#9400d3') {
	      value.style.backgroundColor = 'darkviolet';
	    } else if (value.firstElementChild.innerHTML == '#5e17eb') {
	      value.style.backgroundColor = '#5e17eb';
	    } else if (value.firstElementChild.innerHTML == '#a2efef') {
	      value.style.backgroundColor = '#a2efef';
	    }
    });
	//}
}

var main_container = document.getElementById('main');
main_container.scrollTop = main_container.scrollHeight;

// Ajax 自動更新機能
/*$(function() {
  function buildTHREAD(thread) {
    const threads = document.getElementById('thread-container');
        //threads.('beforeend', data['thread']);
    let user_image = ( thread.user_image ) ? `<img class= 'author-profile-thumbnail' src=${ thread.user_image } >` : `<i class='far fa-user-circle'></i>`;
    let ui_cui = ( thread.user_id == gon.current_user_id ) ? 
              `<a href='/gthreads/${ thread.id }' class='thread-destroy-btn-a' id='thread-destroy-btn-a${ thread.id }' data-method='DELETE' data-remote='true', data-confirm='${ thread.title } を削除してもよろしいですか？'>
                <button type='button' class='btn thread-destroy-btn'>
                  <span class='thread-destroy-icon'>
                    <svg xmlns='http://www.w3.org/2000/svg' fill='currentColor' class='bi bi-trash' viewBox='0 0 16 16'>
                      <path d='M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z'/>
                      <path fill-rule='evenodd' d='M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z'/>
                    </svg>
                  <span>
                </button>
              </a>` : '';
    
    threads.insertAdjacentHTML('beforeend',
        `<div class='thread-index-single' id='thread${ thread.id }' data-id='${ thread.id }'>
          <div class='thread-author-container'>
            <div class='thread-author-thumbnail'>
              ${ user_image }
            </div>
            <div class='thread-author'>
              <div class='thread-author-name'>
                ${ thread.user_accountName }
              </div>
              <div class='thread-created_at'>
                ${ thread.created_at }
              </div>
            </div>
            <div class='thread-title'>
              ${ thread.title }
            </div>
          </div>
  
          <div class='thread-description'>
            ${ thread.description }
          </div>
          
          <div class='thread-reaction-container'>
            <a href=/gthreads/reaction_image_index?id=${ thread.id } class='thread-reaction-btn-a' id='thread-reaction-btn-a${ thread.id }' data-remote='true'>
              <button type='button' class='btn treaction-btn' data-toggle='modal' data-target='#thread-reaction-Modal<%= gthread.id %>'>
                <span class='treaction-icon'>
                  <i class='far fa-laugh'></i>
                </span>
              </button>
            </a>
            <span class='btn treaction-number' data-toggle='modal' data-target='#treaction-Modal${ thread.id }'>
              ${ thread.reactions_count }
              <span class=treaction-number-attached>件のリアクション</span>
            </span>
          
            <div class='modal thread-reaction-Modal' id='thread-reaction-Modal${ thread.id }' tabindex='-1' aria-labelledby='ModalLabel'>
              
            </div><!-- /.modal thread-reaction-Modal -->
            
            <div class='modal treaction-Modal' id='treaction-Modal${ thread.id }' tabindex='-1' aria-labelledby='ModalLabel'>
              
            </div><!-- /.modal treaction-Modal -->
            
            <a href=/gthreads/comment_index?id=${ thread.id } class='tcomment-btn-a' id='tcomment-btn-a${ thread.id }' data-remote='true'>
              <button type='button' class='btn tcomment-btn' data-toggle='modal' data-target='#tcomment-Modal${ thread.id }'>
                <span class='tcomment-icon'>
                  <i class='far fa-comment'></i>
                <span>
              </button>
            </a>
          
            <div class='modal tcomment-Modal' id='tcomment-Modal${ thread.id }' tabindex='-1' role='dialog' aria-labelledby='ModalLabel'>
              
            </div><!-- /.modal tcomment-Modal -->
      
            <button type='button' class='btn treaction-counter'>
              <span class='treaction-number'>
                ${ thread.comments_count }
              </span>
            </button>
            
            ${ ui_cui }
          </div>
        </div>`);
  }

  $(function() {
    //if (document.location.href.match(/\/gthreads\/\d+\/messages/)) {
      setInterval(threads_update, 10000);
      setInterval(reactions_update, 10000);
    //}
  });
  
  function threads_update(){
    if ($('.thread-index-single')[0]) {
      var thread_id = $('.thread-index-single:last').data('id');
    } else {
      var thread_id = 0;
    }
    
    $.ajax({
      url: '/gthreads',
      type: 'GET',
      data: { thread: { id: thread_id } },
      dataType: 'json'
    })
    .always(function(data){ //通信したら、成功しようがしまいが受け取ったデータ（@new_message)を引数にとって以下のことを行う
      $.each(data, function(i, data){ //'data'を'data'に代入してeachで回す
        buildTHREAD(data);
        //const threads = document.getElementById('thread-container');
        //threads.insertAdjacentHTML('beforeend', data['thread']);
      });
    });
  }
  
  function reactions_update(){
    
  }
});*/
