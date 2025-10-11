let loadingCount = 1;
document.documentElement.style.overflow = "hidden";
window.onload = CloseLoadingScreen();

function OpenLoadingScreen() {
  loadingCount++;
}

function CloseLoadingScreen() {
  loadingCount--;
  if(loadingCount <= 0)
  {
    document.getElementById("loading").classList.toggle("fadeOut");
    document.documentElement.style.overflow = "visible";
  }
}
