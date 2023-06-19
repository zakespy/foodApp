import { useEffect,useState } from "react";
import axios from "axios"
import React from "react";
import "../OrderPage/OrderPageStyles.css"
import useWebSocket from "react-use-websocket"
import OrderCard from "../OrderCard/Ordercard";
import Order from "../../classes/Order";
import WebSocket from "ws";
import { WebSocketServer } from 'ws'

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

    const newGrp = newItem.getList();
    const [newOrderList,setNewOrderList] = useState(newGrp.reverse())
    const [data, setData] = useState('');

    function webSocketConnect(){
    }
    
    const deleteOrder = (order_id)=>{
      let index = 0
      let tokenNo
      newGrp.map(e=>{
        if(e.order_id == order_id){
          tokenNo = e.tokenNo
          newGrp.splice(index,1)
        }
        index++
      })
      newItem.removeFromList(order_id)
      setNewOrderList(temp=>({...temp,...newGrp}));
      deleteFromDB(tokenNo)
    }

    async function deleteFromDB(tokenNo){
      await axios.post("http://localhost:8000/api/order/removeOrder",{
        "tokenNo":tokenNo
      }).then(e=>{console.log("deleted")})
    }

    function decodeMsg(msg){
        console.log(msg)     
        const newOrder = JSON.parse(msg.data)
        updateOrderList(newOrder)
        // console.log(ab2str(msg.data))
    } 

    function updateOrderList(order){
      console.log("order",order)
      let count = 0
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
        onMessage: (data) => {
          console.log("data received",data.data)
          decodeMsg(data)}
      }); 

    useEffect(()=>{webSocketConnect()},[])
    
    // useEffect(() => {
    //   const eventSource = new EventSource('http://localhost:8000/api/socket/sse/toDashBoard');
  
    //   eventSource.onmessage = (event) => {
    //     console.log(event.data)
    //     // setData(event.data);
    //     // decodeMsg(data)
    //   };
  
    //   eventSource.onerror = (error) => {
    //     console.error('SSE error:', error);
    //     eventSource.close();
    //   };
  
    //   return () => {
    //     eventSource.close();
    //   };
    // }, []);

    return (
        <>
            <div className="orderPageContainer">
                <div className="orderContainer">
                  {console.log("newOrderList",newOrderList)}
                    {newItem.getList().map(e=>{
                        return <OrderCard newOrder={e} deleteOrder={deleteOrder}/>
                    })}
                    {/* {getWebSocket} */}
                </div> 
            </div> 
        </>
    )
}