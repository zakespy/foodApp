
let requestQueue = []
let tokenNo = 0

// class Queue{
//     static enqueue(body){
//         tokenNo++
//         console.log(`request enqueued ${tokenNo}`)
//         requestQueue.push(body)
//     }

//     static dequeue(){
//         if(requestQueue.length == 0){
//             // console.log("empty request queue")
//         }else{
//             console.log("dequeued")
//             requestQueue.pop()
//         }
//     } 

//     static process(){
//         this.dequeue()
//     }
// }

export function enqueue(body){
    tokenNo++
    console.log(`request enqueued ${tokenNo}`)
    requestQueue.push(body)
    return tokenNo
}

export  function dequeue(){
    if(requestQueue.length == 0){
                    // console.log("empty request queue")
                }else{
                    console.log("dequeued")
                    requestQueue.pop()
                }
}

export function reqProcess(){



    dequeue()
}

// export default Queue