import React from "react";
import "./OrderCard.css";
import item from "./Somosa.jpeg";
import AccessTimeIcon from '@mui/icons-material/AccessTime';
import { useState, useEffect } from "react";

export default function OrderCard({newOrder,deleteOrder}) {

  

  // const newOrder = {
  //   customerEmailId: String,
  //   tokenNo: Number,
  //   orderTime: Date,
  //   orderDetails: [
  //     {
  //       foodName: "chicken tikka",
  //       quantity: 2,
  //       category: [],
  //       foodPrice: 80
  //     },
  //     {
  //       foodName: "Panner tikka",
  //       quantity: 3,
  //       category: [],
  //       foodPrice: 60
  //     },
  //     {
  //       foodName: "Roti",
  //       quantity: 8,
  //       category: [],
  //       foodPrice: 10
  //     },
  //     {
  //       foodName: "chawal",
  //       quantity: 1,
  //       category: [],
  //       foodPrice: 30
  //     },
  //   ],
  //   preparedStatus: Boolean,
  //   claimed: Boolean,
  //   timer:Date,
  //   paymentStatus: Boolean,
  //   transactionId: Number,
  //   bankName: String,
  //   order_id: String
  // }



  const [total, setTotal] = useState()

  function getTotal() {
    let temp = 0
    newOrder.orderDetails.map(e => {
      temp = temp + e.quantity * e.foodPrice
    })
    setTotal(temp)
    console.log("total", temp)
  }


  useEffect(() => { getTotal() }, [])


  return (
    <div className="card-container">
      <div className="mainCont">
        <div className="orderNo">
          <h3>Order No {newOrder.tokenNo}</h3>
        </div>
        <div className="orderInfo">
          <div className="itemName">
            <h4>Name</h4>
            {newOrder.orderDetails.map(e => {
              return <p className="orderDesc">{e.foodName}</p>
            })}
          </div>
          <div className="itemInfo">
            <h4>Quantity</h4>
            {newOrder.orderDetails.map(e => {
              return <p className="orderDesc">{e.quantity}</p>
            })}
          </div>
        </div>
        <div className="orderTotal">
          <div className="itemName">
            Total
          </div>
          <div className="itemInfo">
            {total}
          </div>
        </div>
        <div className="orderIcons">
          <div className="timer">
            <AccessTimeIcon /> {newOrder.timer}
          </div>
          <div className="preCont">
            <button className="preBtn" onClick={()=>{deleteOrder(newOrder.order_id)}}>
              Done
            </button>
          </div>
        </div>
      </div>
    </div>

  )
}








