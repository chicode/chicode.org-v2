import Vue from 'vue'
import AttendeeForm from '../components/AttendeeForm.vue'

new Vue({ el: '#root', components: { AttendeeForm } })

let headSheet = new Image()
let torsoSheet = new Image()
let legSheet = new Image()
let arrow = new Image()
let arrowLeft = new Image()
headSheet.src = "images/jonesjam/Heads.png"
torsoSheet.src = "images/jonesjam/Torsos.png"
legSheet.src = "images/jonesjam/Legs.png"
arrow.src = "images/jonesjam/arrow.png"
arrowLeft.src = "images/jonesjam/arrowflip.png"

let arrows = [
  [130,20,1,0],
  [130,80,1,1],
  [130,140,1,2],
  [320,20,-1,0],
  [320,80,-1,1],
  [320,140,-1,2]
]

let currBody = [4,0,0]
let oldBody = localStorage.getItem("currBody")
if (oldBody !== null) {
  currBody = JSON.parse(oldBody)
}
let ctx
let canvas


window.onload = () => {
  //load characters
  
  canvas = document.getElementById("character")
  ctx = canvas.getContext('2d');

  canvas.addEventListener('click', function(e) {
    let clickpos = getMousePos(canvas, e)
    let x = clickpos.x
    let y = clickpos.y
    for(let i = 0; i < arrows.length; i++) {
      let left = arrows[i][0], right = arrows[i][0]+50;
      let top = arrows[i][1], bottom = arrows[i][1]+50;
      if (right >= x
          && left <= x
          && bottom >= y
          && top <= y) {
        swapBody(arrows[i][3], arrows[i][2])
      }
    }
  }) 

  drawBody(ctx, currBody)
}
//because canvas scale is responsive canvas space and dom space are different
function  getMousePos(canvas, evt) {
  var rect = canvas.getBoundingClientRect(), // abs. size of element
      scaleX = canvas.width / rect.width,    // relationship bitmap vs. element for X
      scaleY = canvas.height / rect.height;  // relationship bitmap vs. element for Y

  return {
    x: (evt.clientX - rect.left) * scaleX,   // scale mouse coordinates after they have
    y: (evt.clientY - rect.top) * scaleY     // been adjusted to be relative to element
  }
}

function drawBody(ctx, body) {
  //I thought the amounts were different but I already made this a set of if statements
  //its too late to make it a for loop rip
  //draw arrows
  //
  
  ctx.clearRect(0,0,500,200)
  
  arrows.map(function(arrowData) {
    if(arrowData[2] < 0) {
      ctx.drawImage(arrow, arrowData[0], arrowData[1], 50, 50);
    }
    else {
      ctx.drawImage(arrowLeft, arrowData[0], arrowData[1], 50, 50)
    }
  })

  if(body[0] > 19) {
    body[0] = 0
  }
  else if(body[0] < 0) {
    body[0] = 19
  }
  if(body[1] > 19) {
    body[1] = 0
  }
  else if(body[1] < 0) {
    body[1] = 19
  }
  if(body[2] > 19) {
    body[2] = 0
  }
  else if(body[2] < 0) {
    body[2] = 19
  }
  let heady = Math.trunc(body[0]/4)
  let headx = body[0]-(heady*4)
  let torsoy = Math.trunc(body[1]/4)
  let torsox = body[1]-(torsoy*4)
  let legy = Math.trunc(body[2]/5)
  let legx = body[2]-(legy*5)
  ctx.drawImage(torsoSheet, torsox*115, torsoy*115, 115, 115, 192, 75, 115, 115)
  ctx.drawImage(legSheet, legx*115, legy*140, 115, 140, 192,70,115,140)
  ctx.drawImage(headSheet,headx*95,heady*95,95,95,202.5,10,95,95)
  localStorage.setItem("currBody", JSON.stringify(body))
}

function swapBody(b, i) {
  currBody[b] += i
  drawBody(ctx, currBody)
}
