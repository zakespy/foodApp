import mongoose from "mongoose";

const historySchema = new mongoose.Schema({
    emailId:String,
    history:[
        {
            orderTime:Date,
            order:[{
                foodName:String,
                quantity:Number,
                category:Number,
                foodPrice:Number
           }]
        }
    ]
})


const historyModel  = mongoose.model("history",historySchema)

export default historyModel 


