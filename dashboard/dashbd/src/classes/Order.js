class Order{
    orderList = []
    getList = ()=>{
        return this.orderList
    }
    add2List = (order)=>{
        this.orderList.push(order)
    }
    removeFromList = (order_id)=>{
        let index = 0
        this.orderList.map(e=>{
            if(e.order_id == order_id){
                this.orderList.splice(index,1)
            }
            index++
        })
    }
   
}

export default Order