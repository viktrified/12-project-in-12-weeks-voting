let boxes = document.querySelectorAll("input[type=checkbox]");
boxes.forEach((b) => b.addEventListener("change", tick));

let divs = document.querySelectorAll(".extra");

function tick(e) {
  let state = e.target.checked;
  boxes.forEach(b => b.checked = false);
  divs.forEach(d => d.style.display = "none");  // so no divs displayed
  e.target.checked = state;
  
  // In HTML divs have been given same IDs as corresponding checkbox names . . . 
  let div = document.getElementById(e.target.name);
  
  if(state)
  {
    div.style.display = "block";
    div.firstElementChild.focus();
  }
  else div.style.display = "none";
}