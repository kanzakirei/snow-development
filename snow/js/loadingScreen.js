document.documentElement.style.overflow = "hidden";

window.onload = function () {
  document.getElementById("loading").classList.toggle("fadeOut");
  document.documentElement.style.overflow = "visible";
}