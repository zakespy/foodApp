import mongoose from "mongoose";

const categorySchema = mongoose.Schema({
    categoryName :String,
    categoryNumber:Number,
})

const categoryModel = mongoose.model("catgeory",categorySchema)

export default categoryModel