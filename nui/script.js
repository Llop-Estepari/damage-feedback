//hitmarkers = [];
//
// window.addEventListener('message', function (event) {
//   if (event.data.type === 'hitmarker') {
//     if (!hitmarkers[event.data.marker]) {
//       const div = document.createElement('div');
//       div.id = `hitmarker-${event.data.marker}`;
//       div.style.zIndex = event.data.marker
//       document.body.appendChild(div);

//       hitmarkers[event.data.marker] = div;
//       hitmarker = div;
//     } else {
//       hitmarker = document.getElementById(`hitmarker-${event.data.marker}`);
//     }

//     hitmarker.innerHTML = event.data.damage;
//     hitmarker.style.top = (event.data.y * 100) + '%';
//     hitmarker.style.left = (event.data.x * 100) + '%';
//     console.log(hitmarkers.length);

//   } else if (event.data.type === 'delete') {
//     const auxHitmarker = document.getElementById(`hitmarker-${event.data.marker}`);
//     if (auxHitmarker instanceof Node) {
//       document.body.removeChild(auxHitmarker);
//     } else {
//       console.error("auxHitmarker is not a valid Node object");
//     }
//   }
// })

const hitmarker = document.getElementById("hitmarker");

var movement = null;

let lastDamage = 0;
let xPos = 0;
let yPos = 0;


function move(){
  hitmarker.style.top = (yPos) + '%';
  hitmarker.style.left = (xPos) + '%';
}

window.addEventListener('message', function (event) {
  if (event.data.type === 'hitmarker') {
    if (event.data.damage != lastDamage) {
      hitmarker.innerHTML = event.data.damage;
      lastDamage = event.data.damage;
    }
    xPos = (event.data.x * 100);
    yPos = (event.data.y * 100);

    clearInterval(movement);
    movement = setInterval(frame, 1);
    function frame() {
      if (hitmarker.style.top == yPos + '%' && hitmarker.style.left == xPos + '%') {
        clearInterval(movement);
      } else {
        move();
      }
    }
    hitmarker.style.display = 'block';

  } else if (event.data.type === 'delete') {
    hitmarker.style.display = 'none';
  }
})


