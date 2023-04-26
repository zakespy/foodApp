import React from "react";
import "./OrderCard.css";


export default function OrderCard(){

    var seconds = 0
    setInterval(upTimer, 1000);
    function upTimer() {
        ++seconds;
        var hour = Math.floor(seconds / 3600);
        var minute = Math.floor((seconds - hour * 3600) / 60);
        var updSecond = seconds - (hour * 3600 + minute * 60);
        document.getElementById("countup").innerHTML = hour + ":" + minute + ":" + updSecond;
    }

    return(
        <>
        <div className="card">
            <div className="details">
                <p className="token">Token No- 12</p>
                <p className="foodname">Samosa</p>
                <p className="price">100 Rupees</p>
            </div>
            <div className="timer">
            <h2 id= "countup">00:00:00</h2>
            </div>
            {/* <div className="delete"> */}
            <button><span>Order Completed</span></button>
            {/* </div> */}
        </div>  
        </>        
    )
}








