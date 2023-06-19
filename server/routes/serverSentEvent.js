import express from 'express'
import sse from 'express-sse'


const router = express.Router();
let newData = 0
setInterval(()=>{
    newData++
},2000)


const emitSSE = (res, id, data) => {
    res.write('id: ' + id + '\n');
    res.write("data: " + data + '\n\n');
    // res.flush()
}

const handleSSE = (req, res) => {
    res.writeHead(200, {
        'Content-Type': 'text/event-stream',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive'
    });
    const id = (new Date()).toLocaleTimeString();
    // Sends a SSE every 3 seconds on a single connection.
    emitSSE(res, id, newData);
    // emitSSE(res, id, (new Date()).toLocaleTimeString());
    // setInterval(function () {
    // }, 3000);

    emitSSE(res, id, (new Date()).toLocaleTimeString());
}


router.get('/sse/toDashBoard',handleSSE)

// sse.send("hii");
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

export default router