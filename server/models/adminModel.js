import mongoose from "mongoose";

const adminSchema = new mongoose.Schema({
    emailId:{type:String,required:true,trim:true},
    password:{type:String,required:true,trim:true},
    name:{type:String},
    phoneNo:{type:String},
    token:{type:String}
})


const adminModel  = mongoose.model("admin",adminSchema)

export default adminModel 