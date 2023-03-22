let requestQueue = []
let tokenNo = 0

class Queue{
    static enqueue(body){
        console.log("request enqueued")
        requestQueue.push(body)
    }

    static dequeue(){
        if(requestQueue.length == 0){
            console.log("empty request queue")
        }else{
            console.log("dequeued")
            requestQueue.pop()
        }
    } 

    static process(){
        this.dequeue()
    }
}

export default Queue