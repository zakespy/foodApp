import React, { useEffect } from 'react'
import { useState } from 'react';
import MenuPage from "../MenuPage/MenuPage";
import OrderPage from "../OrderPage/OrderPage";
import { BrowserRouter, Routes, Route, useNavigate } from "react-router-dom";
import { MenuForm } from "../MenuForm/MenuForm";
import { Outlet, Link } from "react-router-dom";
import Sockette from 'sockette';
import useWebSocket from "react-use-websocket"
import socketCluster from 'socketcluster-client';
import CategoryPage from '../CategoryPage/CategoryPage';
 

// let newData = []


// const ws = new Sockette('ws://localhost:5010', {
//   timeout: 5e3,
//   maxAttempts: 10,
//   onopen: e => console.log('Connected!', e),
//   // onmessage: e => {console.log(e.data)},
//   // onmessage: e => {newData.push(JSON.parse(e.data))
//   // console.log(newData)},
//   onreconnect: e => console.log('Reconnecting...', e),
//   onmaximum: e => console.log('Stop Attempting!', e),
//   onclose: e => console.log('Closed!', e),
//   onerror: e => console.log('Error:', e)
// });

// function sendMsg2Socket(msg){
//   ws.send(JSON.stringify(msg))
// }  




export function Home(){
  const newGrp = []
  const [newData,setNewData] = useState(newGrp)

//   const ws = new Sockette('ws://localhost:5010', {
//   onopen: e => console.log('Connected!', e),
//   onmessage: e => {newGrp.push(JSON.parse(e.data))
//     setNewData(newGrp)
//   console.log("newData",newData)},
//   onreconnect: e => console.log('Reconnecting...', e),
//   onmaximum: e => console.log('Stop Attempting!', e),
//   onclose: e => console.log('Closed!', e),
//   onerror: e => console.log('Error:', e)
// });


// const socket = socketCluster.create({
//   hostname: 'localhost',
//   port: 5010,
//   // path: '/socketcluster/',
//   // secure: true // Set to true if using wss
// });

// socket.on('connect', () => {
//   console.log('Connected to server');
// });

// socket.on('disconnect', () => {
//   console.log('Disconnected from server');
// });

// socket.on('error', (error) => {
//   console.error('Socket error:', error);
// });



  // useEffect(()=>{setNewData(newGrp)},[newGrp])

  return (
    // <BrowserRouter>
    <Routes>
        {/* <Route path="/" exact element={<OrderPage orderGroup={newData}/>} /> */}
        <Route path="/" exact element={<OrderPage orderGroup={newData}/>} />
        <Route path="/menuPage" exact element={<MenuPage />} />
        <Route path="/menu-form" exact element={<MenuForm />} />
        <Route path="/category-form" exact element={<CategoryPage />} />
    </Routes>
// </BrowserRouter>
  )
}
