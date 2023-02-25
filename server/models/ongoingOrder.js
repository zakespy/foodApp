import mongoose, { mongo } from "mongoose";

const ongoingOrderSchema = new mongoose.Schema({
    dayDate : Date,
    order:[
        {
            customerEmailId:String,
            tokenNumber:Number,
            orderTime:Date,
            orderDetails:[{
                foodName:String,
                quantity:Number,
                category:Number,
                foodPrice:Number
           }],
           preparedStatus:Boolean,
           claimed:Boolean,
           paymentStatus:Boolean,
           transactionId:Number,
           bankName:String,
        }
    ]
})

const ongoingOrderModel = mongoose.model("todayorder",ongoingOrderSchema)

export default ongoingOrderModel