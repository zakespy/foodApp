import express from "express";
import bodyParser from "body-parser";
import dotenv from 'dotenv';
import connectDB from "./db/connection.js";
import customer from "./routes/customer.js";
import food from "./routes/food.js";
import category from "./routes/category.js";
import history from "./routes/history.js";
import admin from "./routes/admin.js";
import payment from "./routes/payment.js";
import order from "./routes/order.js"
import {enqueue , dequeue , reqProcess} from "./modules/queue.js";
import http from 'http'
import {WebSocketServer} from 'ws'
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
// app.use(express.json({limit: '3mb'}));

// app.use(bodyParser.json({limit: '50mb', extended: true}));
// app.use(bodyParser.urlencoded({limit: "50mb", extended: true, parameterLimit:50000}));
// app.use(bodyParser.text({ limit: '200mb' }));

// app.use(express.urlencoded({limit: '5mb'}));

// app.use(bodyParser.json({limit: '50mb'}));
// app.use(bodyParser.urlencoded({limit: "50mb", extended: true, parameterLimit:50000}));  

app.use("/api", customer);
app.use("/api/food", food);
app.use("/api/category", category);
app.use("/api/history", history);
app.use("/api/admin", admin);
app.use("/api/payment", payment);
app.use("/api/order",order);

setInterval(()=>{
  reqProcess()
},1000)

const server = http.createServer();
// newSocket(server)
const wss =  new WebSocketServer({ port:5000 });
    wss.on('connection', (ws)=>{
      ws.on('message',message=>{
        // ws.send("true")
        console.log('%s',message)
      })
      setTimeout(()=>{
        ws.send("true")
      },5000)
      console.log('new connection')
    })

    // wss.on('message', function message(data) {
    //   console.log('hello message received: %s ', data);
    //   // wss.send("hiiii")
    // });

    // wss.on('open', function open() {
    //   ws.send('something');
    // });




// connectSocket    
app.listen(port,()=>{
    console.log(`Server LIstening at port http://localhost:${port}`)
})
 