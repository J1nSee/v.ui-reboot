const volume = 0.2;
const music_url = "https://upcdn.io/kW15cBF/raw/TURN_RebotInchan.mp3";

$(document).ready(function() {
  var interval; 

  $(window).on('message', function(event) {
      var event = event.originalEvent;
      var container = $('#container');
      var time = $('#time');

      if (event.data.type === 'rebootNotify') {
          if (event.data.minute > 0) {
              container.show();
              clearInterval(interval);

              let seconds = Number(event.data.minute) * 60;
              var minutes = Math.floor(seconds / 60);
              var secondsNow = seconds - (minutes * 60);
              var audio = new Audio(`${music_url}`);
              audio.play();
              audio.volume = `${volume}`;
              
              // Display the time immediately before starting the interval
              time.html(minutes.toString().padStart(1, "0") + '분' + secondsNow.toString().padStart(2, "0") + '초');

              interval = setInterval(function() { 
                  seconds -= 1;
                  minutes = Math.floor(seconds / 60);
                  secondsNow = seconds - (minutes * 60);

                  time.html(minutes.toString().padStart(1, "0") + '분' + secondsNow.toString().padStart(2, "0") + '초');

                  if (seconds <= 0) {
                      clearInterval(interval);
                      time.html("00분00초");
                  }
              }, 1000);
          }
      }

      if (event.data.type === 'rebootstop') {
          clearInterval(interval);
          container.hide();
          time.empty();
      }
  });
});
