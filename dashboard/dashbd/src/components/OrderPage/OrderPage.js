import { useEffect,useState } from "react";
import axios from "axios"
import React from "react";
import "../OrderPage/OrderPageStyles.css"
import useWebSocket from "react-use-websocket"
import OrderCard from "../OrderCard/Ordercard";
import Order from "../../classes/Order";
// import WebSocket from "ws";

const newItem = new Order()


export default function OrderPage(){
    
    const orderGroup = [
        {
            customerEmailId: String,
            tokenNo: 10,
            orderTime: Date,
            orderDetails: [
              {
                foodName: "chicken tikka",
                quantity: 2,
                category: [],
                foodPrice: 80
              },
              {
                foodName: "Panner tikka",
                quantity: 3,
                category: [],
                foodPrice: 60
              },
              {
                foodName: "Roti",
                quantity: 8,
                category: [],
                foodPrice: 10
              },
              {
                foodName: "chawal",
                quantity: 1,
                category: [],
                foodPrice: 30
              },
            ],
            preparedStatus: Boolean,
            claimed: Boolean,
            timer:Date,
            paymentStatus: Boolean,
            transactionId: Number,
            bankName: String,
            order_id: 'order_123'
          },
          {
            customerEmailId: String,
            tokenNo: 11,
            orderTime: Date,
            orderDetails: [
              {
                foodName: "chicken tikka",
                quantity: 2,
                category: [],
                foodPrice: 80
              },
              {
                foodName: "Panner tikka",
                quantity: 3,
                category: [],
                foodPrice: 60
              },
              {
                foodName: "Roti",
                quantity: 8,
                category: [],
                foodPrice: 10
              },
              {
                foodName: "chawal",
                quantity: 1,
                category: [],
                foodPrice: 30
              },
            ],
            preparedStatus: Boolean,
            claimed: Boolean,
            timer:Date,
            paymentStatus: Boolean,
            transactionId: Number,
            bankName: String,
            order_id: 'order_321'
          },
          {
            customerEmailId: String,
            tokenNo: 12,
            orderTime: Date,
            orderDetails: [
              {
                foodName: "chicken tikka",
                quantity: 2,
                category: [],
                foodPrice: 80
              },
              {
                foodName: "Panner tikka",
                quantity: 3,
                category: [],
                foodPrice: 60
              },
              {
                foodName: "Roti",
                quantity: 8,
                category: [],
                foodPrice: 10
              },
              {
                foodName: "chawal",
                quantity: 1,
                category: [],
                foodPrice: 30
              },
            ],
            preparedStatus: Boolean,
            claimed: Boolean,
            timer:Date,
            paymentStatus: Boolean,
            transactionId: Number,
            bankName: String,
            order_id: 'order_213'
          },
          {
            customerEmailId: String,
            tokenNo: 13,
            orderTime: Date,
            orderDetails: [
              {
                foodName: "chicken tikka",
                quantity: 2,
                category: [],
                foodPrice: 80
              },
              {
                foodName: "Panner tikka",
                quantity: 3,
                category: [],
                foodPrice: 60
              },
              {
                foodName: "Roti",
                quantity: 8,
                category: [],
                foodPrice: 10
              },
              {
                foodName: "chawal",
                quantity: 1,
                category: [],
                foodPrice: 30
              },
            ],
            preparedStatus: Boolean,
            claimed: Boolean,
            timer:Date,
            paymentStatus: Boolean,
            transactionId: Number,
            bankName: String,
            order_id: 'order_132'
          }
    ]

    // const newGrp = orderGroup;
    const newGrp = newItem.getList();
    const [newOrderList,setNewOrderList] = useState(newGrp.reverse())

    function webSocketConnect(){
        // const ws = new WebSocket('wss://localhost:6000/')
        // ws.onopen=function(){
        //     ws.send('hii i m dashboard')
        // }

        // ws.onmessage=function(data){
        //     console.log(data)
        // }

        

        // ws.on('open', function open() {
        //     ws.send('something');
        //   });
          
        //   ws.on('message', function message(data) {
        //     console.log('received: %s', data);
        //   });
    }
    
    const deleteOrder = (order_id)=>{
      let index = 0
      newGrp.map(e=>{
        if(e.order_id == order_id){
          newGrp.splice(index,1)
        }
        index++
      })
      newItem.removeFromList(order_id)
      setNewOrderList(temp=>({...temp,...newGrp}));
      sendMSgSocket(order_id)
    }

    function sendMSgSocket(msg){
      sendJsonMessage(JSON.stringify(msg))
    }
   
    function decodeMsg(msg){
        console.log(msg)     
        console.log(JSON.parse(msg.data))
        const newOrder = JSON.parse(msg.data)
        updateOrderList(newOrder)
        // console.log(ab2str(msg.data))
    } 

    function updateOrderList(order){
      console.log("order",order)
      let count = 0
      // newItem.add2List(order)
      // newGrp.push(order)
      // console.log("updated list",newGrp)
      // setNewOrderList(newGrp)
      if(newItem.getList().length == 0){
        console.log(newItem.getList())
        newItem.add2List(order)
        newGrp.push(order)
        console.log("updated newgrp",newGrp)
        setNewOrderList(newGrp)
        return 
      }else{
        newItem.getList().map(e=>{
          if(e.order_id == order.order_id){
            count++
          }
        })
        if(count == 0){
          newItem.add2List(order)
          newGrp.push(order)
        }
        console.log("updated newgrp",newGrp)
        setNewOrderList(newGrp)
        console.log("aft newGrp",newGrp)
        setNewOrderList(temp=>({...temp,...newGrp}));
      }
      
    }

    const { sendJsonMessage, getWebSocket } = useWebSocket('ws://localhost:5010', {
        onOpen: () => console.log('WebSocket connection opened.'),
        onClose: () => console.log('WebSocket connection closed.'),
        shouldReconnect: (closeEvent) => true,
        onMessage: (data) => {decodeMsg(data)}
      }); 

    useEffect(()=>{webSocketConnect()},[])

    return (
        <>
            <div className="orderPageContainer">
                <div className="orderContainer">
                  {console.log("newOrderList",newOrderList)}
                    {newItem.getList().map(e=>{
                        return <OrderCard newOrder={e} deleteOrder={deleteOrder}/>
                    })}
                    {getWebSocket}
                </div> 
            </div> 
        </>
    )
}