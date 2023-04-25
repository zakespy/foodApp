import {WebSocketServer} from 'ws'

function dashWebSocket(){
    const dashWss =  new WebSocketServer({ port:6000 });
    dashWss.on('connection', (dashWs)=>{
      dashWs.on('message',message=>{
        // ws.send("true")
        console.log('%s',message)
      })
      setTimeout(()=>{
        dashWs.send("true")
      },5000)
      console.log('new connection')
    })

}

export default dashWebSocket