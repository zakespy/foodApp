import mongoose, { Mongoose } from 'mongoose';

const orderSchema = new mongoose.Schema({
    isPaid:Boolean,
    amount:Number,
    order_id:String,
    payment_id:String,
    signature:String,
})

const orderModel = mongoose.model("order", orderSchema);

export default orderModel;