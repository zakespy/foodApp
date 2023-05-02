//admin food category operations

import categoryModel from "../models/categoryModel.js";
import foodModel from "../models/foodModel.js";

class categoryController{
    static getAllCategory = async (req,res)=>{
        await categoryModel.find({}).then(e=>{
            return res.json({categories:e,status:true})
        }).catch(err=>{
            return res.status(500).json({message:"Server error",status:false})
        })
    }

    static addCategory = async (req,res)=>{
        const {categoryName,categoryNumber} = req.body
        await categoryModel.findOne({categoryName:categoryName}).then(async e=>{
            if(e){
                return res.json({message:"Category already exists",status:false})
            }else{
                const newCategory = new categoryModel({categoryName:categoryName,categoryNumber:categoryNumber})
                await newCategory.save().then(e=>{
                    return res.json({message:"Successfully added category",status:true})
                })
            }
        }).catch(err=>{
            console.log(err)
            // return res.status(500).json({message:"Server error",status:false})
        })
    }

    static deleteCategory = async(req,res)=>{
        const {categoryName} = req.body
        await categoryModel.findOne({categoryName:categoryName}).then(async e=>{
            if(e){
                await categoryModel.findOneAndDelete({categoryName:categoryName}).then(e=>{
                    return res.json({message:"Successfully deleted category",status:true})
                })
            }else{
                return res.json({message:"Category does not exists",status:false})
            }
        }).catch(err=>{
            return res.status(500).json({message:"Server error",status:false})
        })
    }

    static editCategory = async (req,res)=>{
        const {categoryName,newCategoryName} = req.body
        await categoryModel.findOne({categoryName:categoryName}).then(async e=>{
            if(e){
                e.categoryName = newCategoryName
                await categoryModel.findOneAndUpdate({categoryName:categoryName},e).then(e=>{
                    return res.json({message:"Successfully updated category",status:true})
                })
            }else{
                return res.json({message:"Category does not exists",status:false})
            }
        }).catch(err=>{
            return res.status(500).json({message:"Server error",status:false})
        })
    } 

    static addCategory2ToAllMenu = async (req,res)=>{
        const {updatedMenu} = req.body
        console.log("updatedMenu",updatedMenu)
        try {
            const newArr = updatedMenu.map(async e=>{
                await foodModel.findOneAndUpdate({foodName:e.foodName},e).then(e=>{console.log(e)})
            })
            newArr.then(e=>{
                return res.json({message:"Succesfully updated all menu",status:true})
            })
        } catch (error) {
            return res.status(500).json({message:"Server error",error:error,status:false})
        }
        
    }
}

export default categoryController