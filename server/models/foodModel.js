import mongoose from "mongoose";

const foodSchema = new mongoose.Schema({
    foodName :{type:String,required:true},
    foodPrice:{type:Number,required:true},
    foodType :{type:String},
})

const foodModel = mongoose.model("food",foodSchema)

export default foodModel