//foodmenu crud operations

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
        const {oldFoodName,foodName,foodPrice,foodCategory,foodImage} = req.body
        console.log(req.body.foodCategory)
        await foodModel.findOne({foodName:oldFoodName}).then(async e=>{
            console.log(e)
            if(e){
                e.foodName = foodName
                e.foodPrice = foodPrice
                // e.foodType = foodType
                e.foodImage = foodImage 
                // console.log("e :",e);
                e.foodCategory = foodCategory
                
                await foodModel.findOneAndUpdate({foodName:foodName},e).then(e=>{
                    return res.json({message:"Successfully updated food",status:true})
                })
                // return res.json({message:"Food already exists",status:false})
            }else{
                const newFood =  new foodModel({foodName,foodPrice,foodCategory,foodImage})
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
        const {foodName,foodPrice,foodCategory,foodImage} = req.body
        // console.log(req.body.foodName)
        await foodModel.findOne({foodName:foodName}).then(async e=>{
            // console.log(e)
            if(e){
                e.foodName = foodName
                e.foodPrice = foodPrice
                // e.foodType = foodType
                e.foodImage = foodImage 
                // console.log("e :",e);
                e.foodCategory = foodCategory
                
                await foodModel.findOneAndUpdate({foodName:foodName},e).then(e=>{
                    return res.json({message:"Successfully updated food",status:true})
                })
            }
            else{
                return res.json({message:"Food Does not exist",status:false})
            }
        }).catch((err)=>{ 
            return res.status(500).json({message:"Server error",status:false,error:err})
        })
    }

    static getFoodCategory  = async (req,res)=>{
        const {foodName} = req.body
        await foodModel.findOne({foodName:foodName}).then(e=>{
            if(e){
                return res.json({category:e.foodCategory,status:true})
            }else{
                return res.json({message:"Food does not exists",status:false})
            }
        }).catch(err=>{
            return res.status(500).json({message:"Server error",status:false})
        })
    }

    static addCategory = async (req,res)=>{
        const {foodName,categoryNumber} = req.body
        await foodModel.findOne({foodName:foodName}).then(async e=>{
            if(e){
                let count = 0;
                e.foodCategory.map(element=>{
                    if(e.categoryNumber == categoryNumber){
                        count++
                    }
                })
                if(count == 0){
                    e.foodCategory.push(categoryNumber)
                    await foodModel.findOneAndUpdate({foodName:foodName},e).then(e=>{
                        return res.json({message:"Successfully added category",status:true})
                    })
                }else{
                    return res.json({message:"Category already exists",status:false})
                }
            }else{
                return res.json({message:"food does not exists",status:false})
            }
        }).catch(err=>{
            return res.status(500).json({message:"Server error",status:false})
        })
    }

    static deleteCategory = async (req,res)=>{
        const {foodName,categoryNumber} = req.body
        await foodModel.findOne({foodName:foodName}).then(async e=>{
            if(e){
                let count = 0;
                let index = -1
                e.foodCategory.map(element=>{
                    if(e.categoryNumber == categoryNumber){
                        index = count
                    }
                    count++
                })
                if(index != -1){
                    e.foodCategory.splice(index,1)
                    await foodModel.findOneAndUpdate({foodName:foodName},e).then(e=>{
                        return res.json({message:"Successfully removed category",status:true})
                    })
                }else{
                    return res.json({message:"Category does not exists",status:false})
                }
            }else{
                return res.json({message:"food does not exists",status:false})
            }
        }).catch(err=>{
            return res.status(500).json({message:"Server error",status:false})
        })
    }

}

export default foodController;