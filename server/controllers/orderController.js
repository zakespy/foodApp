import {enqueue , dequeue , reqProcess} from "../modules/queue.js";
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
       const cog = await enqueue(req.body)
       res.json({tokenNo:cog})
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

}

export default orderController