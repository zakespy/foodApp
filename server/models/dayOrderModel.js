import mongoose from "mongoose";

const dayOrderSchema = new mongoose.Schema({
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

const dayOrderModel = mongoose.model("dayOrder",dayOrderSchema)
export default dayOrderModel

