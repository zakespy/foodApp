import express from "express";
// import bodyParser from "body-parser";
import cors from 'cors'
import dotenv from 'dotenv';
import connectDB from "./db/connection.js";
import customer from "./routes/customer.js";
import food from "./routes/food.js";
import category from "./routes/category.js";
import history from "./routes/history.js";
import admin from "./routes/admin.js";
import payment from "./routes/payment.js";
import order from "./routes/order.js"
import dayOrder from "./routes/dayOrder.js"
import serverSentEvent from "./routes/serverSentEvent.js"
import { enqueue, dequeue, reqProcess } from "./modules/queue.js";
import http from 'http'
import { WebSocketServer } from 'ws'
import WebSocket from 'ws';
import bodyParser from 'body-parser';
import dashWebSocket from "./modules/dashWebSocket.js";
// import connectSocket  from "./modules/webSocket.js"; 
// import {newSocket} from "../server/modules/webSocket.js"

const app = express()
// const server = http.createServer(app)
dotenv.config({ path: "./config.env" });

const port = process.env.port || '8000'
const DATABASE_URL =
  process.env.DATABASE_URL


connectDB(DATABASE_URL) //connection

// app.use(createSocket())
app.use(express.json());
// app.use(express.json({ limit: '50mb' }))
app.use(bodyParser.json({limit:"30mb",extended:true}))
app.use(bodyParser.urlencoded({limit:"30mb",extended:true}))
app.use(cors())
app.use("/api", customer);
app.use("/api/food", food);
app.use("/api/category", category);
app.use("/api/history", history);
app.use("/api/admin", admin);
app.use("/api/payment", payment);
app.use("/api/order", order);
app.use("/api/dayOrder", dayOrder);
app.use("/api/socket",serverSentEvent)

setInterval(() => {
  reqProcess()
}, 1000)

const server = http.createServer();
// newSocket(server)

const wss = new WebSocketServer({ port: 5000 });
//client websocket
wss.on('connection', function connection(ws) {
  // setInterval(()=>{ws.send("hiii")},1000)
  console.log("connected")
  // ws.on('message',(data)=>{
  //   console.log(data)
  //   var enc = new TextDecoder("utf-8");
  //   var arr = new Uint8Array(data);
  //   console.log(enc.decode(arr));
  //   ws.send(JSON.stringify(enc.decode(arr)))
  // })
  ws.on('message', function incoming(data,isBinary) {
    console.log("message received",data)
    var enc = new TextDecoder("utf-8");
    var arr = new Uint8Array(data);
    const decodedData = enc.decode(arr)
    console.log("decoded data",decodedData);
    console.log("again stringify data",JSON.stringify(decodedData));
    wss.clients.forEach(function each(client) {
      if (client !== ws && client.readyState === WebSocket.OPEN) {
        // client.send(JSON.stringify(decodedData), { binary: isBinary });
        // client.send(JSON.stringify(decodedData), { binary: isBinary });
        client.send("true", { binary: isBinary });
      }
    })
  })
  ws.on('headers', (headers) => {
    headers.push('Access-Control-Allow-Origin: *');
  });
  ws.on('request', (request, response) => {
    response.setHeader('Access-Control-Allow-Origin', '*');
    response.writeHead(200);
    response.end('WebSocket server is up and running!');
  })

  
  console.log('new connection')
})




// dashWebSocket()
const newOrder = {
  customerEmailId: String,
  tokenNo: 20,
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
  timer: Date,
  paymentStatus: Boolean,
  transactionId: Number,
  bankName: String,
  order_id: 'order_412'
}

// dashboard websocket

const dashWss = new WebSocketServer({ port: 5010 });

dashWss.on('connection', function connection(ws) {
  console.log("connected")
  ws.on('message', function incoming(data,isBinary) {
    console.log("message received",data)
    dashWss.clients.forEach(function each(client) {
      if (client !== ws && client.readyState === WebSocket.OPEN) {
        client.send(data, { binary: isBinary });
      }
    })
  })
  ws.on('headers', (headers) => {
    headers.push('Access-Control-Allow-Origin: *');
  });
  ws.on('request', (request, response) => {
    response.setHeader('Access-Control-Allow-Origin', '*');
    response.writeHead(200);
    response.end('WebSocket server is up and running!');
  })

  
  console.log('new connection')
})


app.use(bodyParser.json({ limit: "50mb" }));
app.use(
  bodyParser.urlencoded({
    limit: "50mb",
    extended: true,
    parameterLimit: 50000,
  })
);



// connectSocket    
app.listen(port, () => {
  console.log(`Server LIstening at port http://localhost:${port}`)
})
