import mongoose from "mongoose";

const foodSchema = new mongoose.Schema({
    foodName :{type:String,required:true},
    foodPrice:{type:Number,required:true},
    foodImage:String,
    foodCategory :[{
        categoryName:String,
        isPresent:Boolean
    }]
})

const foodModel = mongoose.model("food",foodSchema)

export default foodModel