import mongoose from "mongoose";

const customerSchema = new mongoose.Schema({
    emailId:{type:String,required:true,trim:true},
    password:{type:String,required:true,trim:true},
    name:{type:String},
    phoneNo:{type:String},
    token:{type:String}
})

const customerModel  = mongoose.model("customer",customerSchema)

export default customerModel