import { useEffect,useState } from "react";
import axios from "axios"
import React from "react";
import "../OrderPage/OrderPageStyles.css"
import useWebSocket from "react-use-websocket"
import OrderCard from "../OrderCard/Ordercard";
// import WebSocket from "ws";

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
            order_id: String
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
            order_id: String
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
            order_id: String
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
            order_id: String
          }
    ]

    const newGrp = [];

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
    const decoder = new TextDecoder('iso-8859-1')
    function decodeMsg(msg){
        console.log(msg)
        // let data = new Uint8Array(msg.data); // convert ArrayBuffer to Uint8Array
        // let view = new DataView(data.buffer); // create DataView using the ArrayBuffer

        // let value1 = view.getUint16(0); // read a 16-bit unsigned integer at byte offset 0
        // let value2 = view.getFloat32(2);
        // console.log(value1)
        // console.log(value2)
        const newData = decoder.decode(msg)
        console.log(JSON.parse(newData))
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
                    {orderGroup.map(e=>{
                        return <OrderCard newOrder={e}/>
                    })}
                    {getWebSocket}
                </div> 
            </div> 
        </>
    )
}