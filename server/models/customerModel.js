import mongoose from "mongoose";

const customerSchema = new mongoose.Schema({
    emailId:{type:String,required:true,trim:true},
    password:{type:String,required:true,trim:true},
})

const customerModel  = mongoose.model("customer",customerSchema)

export default customerModel