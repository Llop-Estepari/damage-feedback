const hitmarker = document.getElementById("hitmarker");

var movement = null;
let lastDamage = 0;
let xPos = 0;
let yPos = 0;
let indicatorTime = 0;

function loadSettings(data){
  hitmarker.style.color = data.color;
  hitmarker.style.webkitTextStrokeColor = data.outlineColor;
  hitmarker.style.webkitTextStrokeWidth = data.outlineWidth + 'px';
  hitmarker.style.fontSize = data.fontSize + 'px';
  indicatorTime = data.indicatorLifetime + 5;
}

function move(){
  hitmarker.style.top = (yPos) + '%';
  hitmarker.style.left = (xPos) + '%';
}

function resetAnimation(){
  hitmarker.style.animation = 'none';
  setTimeout(function() {
    const anim = 'fade-out ' + indicatorTime + 's ease';
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
  // if (data.distance > 18) {
  // } else {
  //   yPos = (data.y * 100) + (20 - data.distance);
  // }

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
    console.log('Settings loaded!');
    loadSettings(event.data);
  }
})