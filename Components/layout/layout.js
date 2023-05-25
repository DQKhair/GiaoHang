

// Xử lí thu nhỏ sidebar

let minimize_button = document.getElementById("minimize-button");
let wrap_sidebar = document.querySelector(".wrap-sidebar");
let mini_icon = document.querySelector(".mini-icon");
let space = document.querySelector(".space");
let logoName = document.querySelector(".logo-name");
minimize_button.onclick = function(){
    if(wrap_sidebar.classList.contains("toggled")){
        wrap_sidebar.classList.remove("toggled");
        space.classList.remove("toggled");
        mini_icon.classList.replace("bx-chevron-right","bx-chevron-left");
        document.querySelector(".wrap-content").style.width = "calc(100% - 16rem)";
        logoName.classList.remove("toggled");
    }else{
        wrap_sidebar.classList.add("toggled");
        space.classList.add("toggled");
        mini_icon.classList.replace("bx-chevron-left","bx-chevron-right");
        document.querySelector(".wrap-content").style.width = "calc(100% - 5.2rem)";
        logoName.classList.add("toggled");
    }
}