import mongoose from "mongoose";

const historySchema = new mongoose.Schema({
    emailId:String,
    history:[
        {
            orderTime:new Date(),
            order:[{
                foodName:String,
                quantity:Number,
                category:Number
           }]
        }
    ]
})

const historyModel = mongoose.model("history",historySchema)

export default historyModel