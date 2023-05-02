import mongoose, { mongo } from "mongoose";

const ongoingOrderSchema = new mongoose.Schema({
    customerEmailId: String,
    tokenNo: Number,
    orderTime: Date,
    orderDetails: [{
        foodName: String,
        quantity: Number,
        category: [],
        foodPrice: Number
    }],
    preparedStatus: Boolean,
    claimed: Boolean,
    paymentStatus: Boolean,
    transactionId: Number,
    bankName: String,
    order_id: String

})

const ongoingOrderModel = mongoose.model("todayorder", ongoingOrderSchema)

export default ongoingOrderModel