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
import { enqueue, dequeue, reqProcess } from "./modules/queue.js";
import http from 'http'
import { WebSocketServer } from 'ws'
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

setInterval(() => {
  reqProcess()
}, 1000)

const server = http.createServer();
// newSocket(server)

//client websocket
const wss = new WebSocketServer({ port: 5000 });
wss.on('connection', (ws) => {
  ws.on('message', message => {
    // ws.send("true")
    console.log('%s', message)
  })
  setTimeout(() => {
    ws.send("true")
  }, 5000)
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
dashWss.on('connection', (dashWs) => {
  dashWs.on('message', message => {
    // ws.send("true")
    console.log(JSON.parse(message))
  })
  dashWs.on('headers', (headers) => {
    headers.push('Access-Control-Allow-Origin: *');
  });
  dashWs.on('request', (request, response) => {
    response.setHeader('Access-Control-Allow-Origin', '*');
    response.writeHead(200);
    response.end('WebSocket server is up and running!');
  })
  setInterval(() => {
   
    dashWs.send(JSON.stringify(newOrder))
  }, 5000)
  console.log('new connection')
})




// wss.on('message', function message(data) {
//   console.log('hello message received: %s ', data);
//   // wss.send("hiiii")
// });

// wss.on('open', function open() {
//   ws.send('something');
// });

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
