import React from "react";
import "./OrderCard.css";
import item from "./Somosa.jpeg";

export default function OrderCard(){

    var minutesLabel = document.getElementById("minutes");
    var secondsLabel = document.getElementById("seconds");
    var totalSeconds = 0;
    setInterval(setTime, 1000);
  
    function setTime() {
      ++totalSeconds;
      secondsLabel.innerHTML = pad(totalSeconds % 60);
      minutesLabel.innerHTML = pad(parseInt(totalSeconds / 60));
    }
  
    function pad(val) {
      var valString = val + "";
      if (valString.length < 2) {
        return "0" + valString;
      } else {
        return valString;
      }
    }
    
    return(    
    <div className="card">

        <div class="left">
        <img src={item} alt="hii" className="pic"/>
        </div>

        <div className="right">

        <div className="detail">
            <p className="token">Token 33</p>
            <p className="name">Samosa</p>
            <p className="price">Rs. 20</p>
        </div>
        
        <div className="timer">
            <label id="minutes">00</label>
            <label id="colon">:</label>
            <label id="seconds">00</label>
        </div>

        <div className="delete">
        <button>
            <span class="transition"></span>
            <span class="gradient"></span>
            <span class="label">Order Completed</span>
        </button>
        </div>

        </div>
    </div>
  
    )
}








