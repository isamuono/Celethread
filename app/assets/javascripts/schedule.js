var select = function(start, end, allDay) {
        var title = window.prompt("title");
        var data = {event: {title: title,
                            start: start.format(),
                            end: end.format(),
                            allDay: allDay}};
        $.ajax({
            type: "POST",
            url: "/events",
            data: data,
            success: function() {
                calendar.fullCalendar('refetchEvents');
            }
        });
        calendar.fullCalendar('unselect');
    };

    var calendar = $('#calendar').fullCalendar({
        events: '/events.json',
        selectable: true,
        selectHelper: true,
        ignoreTimezone: false,
        select: select
    });
    
$(function () {
  // 画面遷移を検知
  $(document).on('turbolinks:load', function () {
    if ($('#calendar').length) {
      function eventCalendar() {
        return $('#calendar').fullCalendar({
        });
      }
      function clearCalendar() {
        $('#calendar').html('');
      }
      
      $(document).on('turbolinks:load', function () {
        eventCalendar();
      });
      $(document).on('turbolinks:before-cache', clearCalendar);
      
      //events: '/events.json', 以下に追加
      $('#calendar').fullCalendar({
        /*select: function(start, end, starttime, endtime, place) {
          var title = prompt('イベントを追加');
          var eventData;
          if (title) {
            eventData = {
              title: title,
              start: startdate,
              end: enddate
              //starttime: starttime,
              //endtime: endtime,
              //place: place
            };
            $('#calendar').fullCalendar('renderEvent', eventData, true);
          }
          $('#calendar').fullCalendar('unselect');
        },*/
        events: [
                    {
                        title: 'event1',
                        start: '2020-05-24'
                    },
                    {
                        title: 'event2',
                        start: '2020-04-30',
                        end: '2020-05-03'
                    },
                    {
                        title: 'event3',
                        start: '2020-05-19 12:30:00',
                        allDay: false // will make the time show
                    }
                ],//'/events.json',
        //カレンダー上部を年月で表示させる
        titleFormat: 'YYYY年 M月',
        //曜日を日本語表示
        dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
        //ボタンのレイアウト
        header: {
          left: '',
          center: 'title',
          right: 'today prev,next'
        },
        //終了時刻がないイベントの表示間隔
        defaultTimedEventDuration: '03:00:00',
        buttonText: {
          prevYear: '前年',
          nextYear: '翌年',
          month: '月',
          week: '週',
          day: '日'
        },
        // Drag & Drop & Resize
        editable: true,
        //イベントの時間表示を２４時間に
        timeFormat: "HH:mm",
        //イベントの色を変える
        eventColor: '#87cefa',
        //イベントの文字色を変える
        eventTextColor: '#000000',
        eventRender: function(event, element) {
          element.css("font-size", "0.8em");
          element.css("padding", "5px");
        }
      });
    }
  });
});