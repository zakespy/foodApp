import foodModel from "../models/foodModel.js";

class foodController{

    static getMenu = async(req,res)=>{
        const menu = await foodModel.find()
        return res.json({menu:menu,status:true})
    }

    static getFood = async(req,res)=>{
        const {foodName} = req.body
        await foodModel.findOne({foodName:foodName}).then(e=>{
            if(e){
                return res.json({food:e,status:true})
            }else{
                return res.json({message:"food does not exists",status:false})
            }
        }).catch(err=>{
            return res.status(500).json({message:"Server error",status:false})
        })
    }

    static addFood = async (req,res)=>{
        const {foodName,foodPrice,foodType} = req.body
        await foodModel.findOne({foodName:foodName}).then(async e=>{
            if(e){
                return res.json({message:"Food already exists",status:false})
            }else{
                const newFood =  new foodModel({foodName,foodPrice,foodType})
                await newFood.save().then(e=>{
                    return res.json({message:"Successfully added food",status:true})
                })
            }
        }).catch(err=>{
            return res.status(500).json({message:"server error",status:false})
        })
    }

    static removeFood = async(req,res )=>{ 
        const {foodName} = req.body
        console.log(req.body.foodName)
        await foodModel.findOne({foodName:foodName}).then(async e=>{
            if(e){
                await foodModel.findOneAndDelete({foodName:foodName}).then(e=>{
                    return res.json({message:"Succesfully deleted food",status:true})
                })
            }else{
                return res.json({message:"Food doesn't exist",status:false})
            }
        }).catch(err=>{
            return res.status(500).json({message:"Server error",status:false})
        }) 
    }

    static editFood = async(req,res)=>{
        const {foodName,foodPrice,foodType} = req.body
        await foodModel.findOne({foodName:foodName}).then(async e=>{
            if(e){
                e.foodName = foodName
                e.foodPrice = foodPrice
                e.foodType = foodType
                await foodModel.findOneAndUpdate({foodName:foodName},e).then(e=>{
                    return res.json({message:"Successfully updated food",status:true})
                })
            }
            else{
                return res.json({message:"Food Does not exist",status:false})
            }
        }).catch(err=>{ 
            return res.status(500).json({message:"Server error",status:false})
        })
    }

    static createCombination = async(req,res)=>{
        const {foodName} = req.body

    }
}

export default foodController;