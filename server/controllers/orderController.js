import ongoingOrderModel from "../models/ongoingOrder.js";
import {enqueue , dequeue , reqProcess} from "../modules/queue.js";
import { WebSocketServer } from 'ws'
import WebSocket from 'ws';

// import dayOrderModel from "../models/dayOrderModel.js";
// import ongoingOrderModel from "../models/ongoingOrder.js";
// import Queue from 'bull' 
// import Agenda from 'agenda';
// // import RequestQueue from 'node-request-queue';
// import RequestQueue from 'node-request-queue'
// const mongoConnectionString = 'mongodb+srv://zakespy:Exodus%40123@cluster0.8kk4kls.mongodb.net/foodApp?retryWrites=true&w=majority';

// const agenda = new Agenda({ db: { address: mongoConnectionString },processEvery: '1 seconds' },);

// const queue = new RequestQueue({
//     maxSockets:1
//     // maxConcurrent: 2, // maximum number of concurrent requests
//     // maxQueueSize: 100, // maximum number of queued requests
//     // maxRetries: 3, // maximum number of retries for failed requests
//     // retryDelay: 1000, // delay between retries (in milliseconds)
//     // timeout: 5000, // request timeout (in milliseconds)
//   });

// let requestQueue = []
// let orderNo = 0

class orderController{

    static createToken = async (req,res)=>{
        console.log(res.body)
        const tokenNo = await enqueue(req.body)
        res.json({tokenNo:tokenNo})
        // agenda.define('myJob', (job, done) => {
        //     console.log(job)
        //     console.log('Running myJob');
        //     done();
        //   });
          
        //   agenda.start();
        // queue.enqueue({
        //     url: 'http://localhost:8000/api/order/createToken',
        //     method: 'POST',
        //     body: {foo: 'bar'},
        //     headers: {'Content-Type': 'application/json'},
        //   })
        //   .then(response => {
        //     console.log('Request succeeded with response:', response);
        //   })
        //   .catch(error => {
        //     console.error('Request failed with error:', error);
        //   });
       
    }

    // static createOnGoingOrder = async (req,res)=>{
    //     const {tokenNo, order_id, orderDetails} = req.body 
    //     console.log("inside api create ongoing order",req.body.orderDetails)
        
        
    //     try {
    //         const newOngoingOrder = new ongoingOrderModel({
    //             tokenNo: tokenNo,
    //             order_id: order_id,
    //             orderDetails: orderDetails,
    //             claimed: false,
    //             preparedStatus: false
    //         })
    //         console.log("ongoingorder",newOngoingOrder)
            
    //         newOngoingOrder.save().then(async e=>{
    //             // const dashWss = new WebSocketServer({ port: 5010 });
    //             // dashWss.on('connection', (dashWs) => {
    //             //     dashWs.send(stringOrder)
    //             //     dashWs.on('message', message => {
    //             //       // ws.send("true")
    //             //       // console.log("message received",JSON.parse(message))
    //             //       console.log("closing message")
    //             //       dashWss.close()
    //             //     //   console.log("data send",message)
    //             //     //   setInterval(()=>{ 
    //             //     //     dashWs.send(stringOrder)
    //             //     //   },1000)
                      
    //             //     })
    //             //     dashWs.on('headers', (headers) => {
    //             //       headers.push('Access-Control-Allow-Origin: *');
    //             //     });
    //             //     dashWs.on('request', (request, response) => {
    //             //       response.setHeader('Access-Control-Allow-Origin', '*');
    //             //       response.writeHead(200);
    //             //       response.end('WebSocket server is up and running!');
    //             //     })
    //             //     // setInterval(() => {
                     
    //             //     //   dashWs.send(JSON.stringify(newOrder))
    //             //     // }, 5000)
    //             //     console.log('new connection')
    //             //   })
    //             //   dashWss.close()
                  
    //             const order = await ongoingOrderModel.findOne({order_id:order_id})
    //             console.log("order",order)
    //             const newOrder = {
    //                 "order_id":order_id,
    //                 "tokenNo":tokenNo,
    //                 "orderDetails":order.orderDetails
    //             }
    //             const stringOrder = JSON.stringify(newOrder)
    //             console.log("stringifies data",stringOrder)
    //             const ws = new WebSocket('ws://localhost:5010');
                
    //             ws.addEventListener('open', () => {
    //                 ws.send(stringOrder);
    //                 console.log('WebSocket connection established.');
    //                 ws.close()
    //             });
              
    //           ws.addEventListener('message', event => {
    //             console.log(`Received message: ${event.data}`);
    //           });
              
    //             ws.addEventListener('close', () => {
    //                 console.log('WebSocket connection closed.');
    //             });
    //             // ws.send(JSON.stringify(newOrder));
    //             console.log("succesfull")
    //             res.json({message:"Successfully added order",status:true})
    //         })            
    //     } catch (error) {
    //         res.status(500).json({message:"Server error",error:error,status:false})
    //     } 
    // }

    static createOnGoingOrder = async (req,res)=>{
        const {tokenNo,order_id,orderDetails} = await req.body
        setTimeout(async ()=>{
            console.log("orderDetails",orderDetails)
            const newDetails = orderDetails
            console.log("neDetails",newDetails)
        try {
            const newOrder ={
                "order_id":order_id,
                "orderDetails":orderDetails,
                "tokenNo":tokenNo
            }

            const newOngoingOrder = new ongoingOrderModel({
                tokenNo: tokenNo,
                order_id: order_id,
                orderDetails: orderDetails,
                claimed: false,
                preparedStatus: false
            })
            await newOngoingOrder.save().then(async e=>{
                const details = await ongoingOrderModel.findOne({order_id: order_id});
                newOrder.orderDetails = [
                    { foodName: 'Dosa', foodPrice: 40, quantity: 1 },
                    { foodName: 'Daal', foodPrice: 30, quantity: 1 },
                  ];
                console.log("newOrder",newOrder.orderDetails)
                
                const ws = new WebSocket('ws://localhost:5010');
                            ws.addEventListener('open', () => {
                                ws.send(JSON.stringify(newOrder));
                                console.log('WebSocket connection established.');
                                ws.close()
                            });
                          
                          ws.addEventListener('message', event => {
                            console.log(`Received message: ${event.data}`);
                          });
                          
                            ws.addEventListener('close', () => {
                                console.log('WebSocket connection closed.');
                            });
                            // ws.send(JSON.stringify(newOrder));
                            return res.json({ message:"success", status: true })
            })
        } catch (error) {
            return res.status(500).json({message:"Server error",error:error,status:false})
        }
        },2000)
        
    }

    static removeOngoingOrder = async (req, res) => {
        const { tokenNo } = req.body;

        try {
            ongoingOrderModel.findOneAndDelete( { tokenNo: tokenNo }).then(e=>{
                const ws = new WebSocket('ws://localhost:5000');
                
                ws.addEventListener('open', () => {
                    ws.send(tokenNo);
                    console.log('WebSocket connection established.');
                    ws.close()
                });
              
              ws.addEventListener('message', event => {
                console.log(`Received message: ${event.data}`);
              });
              
                ws.addEventListener('close', () => {
                    console.log('WebSocket connection closed.');
                });
                return res.json({message:"Successfully deleted order",status:true})
            });
        } catch (error) {
            res.status(500).json({message:"Server error",status:false})
        }
    }

    static deleteOnGoingOrder = async (req,res)=>{
        const {order_id} = req.body
        try {
            await ongoingOrderModel.findOneAndRemove({order_id:order_id}).then(e=>{
                return res.json({message:"Succesfully deleted order",status:true})
            })
        }catch(error){
            return res.status(500).json({message:"Server error",error:error})
        }
    }
}

export default orderController