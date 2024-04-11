const hitmarker = document.getElementById("hitmarker");

var movement = null;
let lastDamage = 0;
let xPos = 0;
let yPos = 0;
let indicatorTime = '1s';

function loadSettings(data){
  hitmarker.style.color = data.color;
  hitmarker.style.webkitTextStrokeColor = data.outlineColor;
  hitmarker.style.webkitTextStrokeWidth = data.outlineWidth + 'px';
  hitmarker.style.fontSize = data.fontSize + 'px';
  hitmarker.style.fontFamily = data.font;
  indicatorTime = (data.indicatorLifetime + 20) / 100 + 's';
}

function move(){
  hitmarker.style.top = (yPos) + '%';
  hitmarker.style.left = (xPos) + '%';
}

function resetAnimation(){
  hitmarker.style.animation = 'none';
  setTimeout(function() {
    const anim = 'fade-out ' + indicatorTime + ' ease-in-out';
    hitmarker.style.animation = anim;
}, 10);
}

function hitmarkerData(data) {
  if (data.resetMarker) {
    resetAnimation();
  }
  if (data.damage != lastDamage) {
    hitmarker.innerHTML = data.damage;
    lastDamage = data.damage;
  }
  xPos = (data.x * 100);
  yPos = (data.y * 100);

  clearInterval(movement);
  movement = setInterval(updateMovement, 1);
  function updateMovement() {
    if (hitmarker.style.top == yPos + '%' && hitmarker.style.left == xPos + '%') {
      clearInterval(movement);
    } else {
      move();
    }
  }
  hitmarker.style.display = 'block';
}

window.addEventListener('message', function (event) {
  if (event.data.type === 'HITDATA') {
    hitmarkerData(event.data);
  } else if (event.data.type === 'DELETE') {
    hitmarker.style.display = 'none';
  } else if (event.data.type === 'SETTINGS') {
    //console.log('Settings loaded!');
    loadSettings(event.data);
  }
})

$(document).ready(function() {
  $.post('https://damage_indicator/loadsettings');
});