// import io from 'socket.io'(3000);
// import WebSocket from 'ws'
import {WebSocketServer} from 'ws'
import WebSocket from 'ws'

function newSocket(ser){
    // const ws1 = new WebSocket('ws://localhost:3000/path1');
    
    
    // const sockserver = new WebSocketServer({ port: 443 })


    // sockserver.on('connection', ws => {
    //     console.log('New client connected!')
    //     ws.send('connection established')
    //     ws.on('close', () => console.log('Client has disconnected!'))
    //     ws.on('message', data => {
    //       sockserver.clients.forEach(client => {
    //         console.log(`distributing message: ${data}`)
    //         client.send(`${data}`)
    //       })
    //     })
    //     ws.onerror = function () {
    //       console.log('websocket error')
    //     }
    //    })


    const wss =  new WebSocketServer({ port:5000 });
    wss.on('connection', function (ws) {
        console.log('new connection')
    })

}

// export function  newSocket()

const connectSocket = ()=>{
    const ws = new WebSocket('ws://localhost:5000');

    ws.on('error', console.error);

    ws.on('open', function open() {
        // ws.send('something');
    });

    ws.on('message',message=>{
        // console.log(message)
        console.log('%s',message)
        ws.send("hii server im client")
    })

    // ws.on('message', (data)=>{
    // console.log('received: %s', data);
    // console.log("hiii server here client")
    //     ws.send("Hiii server i m client")
    // });

    ws.on('connection', data=>{
    console.log('received: %s', data);
        // ws.send("hii")
        // data.on('message',message=>{
        //     message.send("Hiii server i m client")
        // })
    });


}
// function connectSocket(){
//     const ws = new WebSocket('ws://localhost:5000');

//     ws.on('error', console.error);

//     ws.on('open', function open() {
//         ws.send('something');
//     });

//     ws.on('message', function message(data) {
//     console.log('received: %s', data);
//     });
// }

export  default connectSocket()