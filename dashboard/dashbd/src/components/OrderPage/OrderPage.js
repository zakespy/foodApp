import { useEffect,useState } from "react";
import axios from "axios"
import React from "react";
import "../OrderPage/OrderPageStyles.css"
import useWebSocket from "react-use-websocket"
import OrderCard from "../OrderCard/Ordercard";
// import WebSocket from "ws";

export default function OrderPage(){
    
    

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


    const { sendJsonMessage, getWebSocket } = useWebSocket('ws://localhost:5010', {
        onOpen: () => console.log('WebSocket connection opened.'),
        onClose: () => console.log('WebSocket connection closed.'),
        shouldReconnect: (closeEvent) => true,
        onMessage: (data) => {console.log("response data ",data.data)}
      });


    useEffect(()=>{webSocketConnect()})

    return (
        <>
            <div className="orderPageContainer">
                <div className="orderContainer">
                    <OrderCard/>
                </div> 
            </div> 
        </>
    )
}