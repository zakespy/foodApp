import express from 'express'
import SSE from 'express-sse'


const router = express.Router();
var sse = new SSE(["array", "containing", "initial", "content", "(optional)"]);
router.get('/sse/toDashBoard',sse.init())

sse.send("hii");
// router.get('/sse/toDashBoard', (req, res) => {
//     res.setHeader('Content-Type', 'text/event-stream');
//     res.setHeader('Cache-Control', 'no-cache');
//     res.setHeader('Connection', 'keep-alive');
//     res.setHeader('Access-Control-Allow-Origin', '*');

//     // Send initial response to the client
//     res.write('data: Connected\n\n');

//     // Set up periodic data updates
//     // const intervalId = setInterval(() => {
//     //     res.write(`data: ${new Date().toISOString()}\n\n`);
//     // }, 1000);

//     // Clean up the SSE connection
//     req.on('close', () => {
//         // clearInterval(intervalId);
//         console.log("closed")
//     });
// })

export  default router