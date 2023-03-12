//customer orders history record

import historyModel from "../models/historyModel.js";

class historyController{
    static getHistory = async (req,res)=>{
        const {emailId} = req.body
        await historyModel.find({emailId:emailId}).then(e=>{
            if(e){
                return res.json({history:e,status:true})
            }else{
                return res.json({message:"No history",status:false})
            }
        }).catch(err=>{
            return res.status(500).json({message:"Server error",status:false})
        })
    }

    static addHistory = async (req,res)=>{
        const {emailId,orderList} = req.body
        await historyModel.find({emailId:emailId}).then(async e=>{
            if(e){
                e.order = new Date() 
                e.order.push(orderList)
                await historyModel.findOneAndUpdate({emailId:emailId},e).then(e=>{
                    return res.json({message:"Succesfully added to history",status:true})
                })
                // return res.json({history:e,status:true})
            }else{
                const order = [orderList]
                const newHistory = new historyModel({emailId:emailId,history:order})
                await historyModel.save().then(e=>{
                    return res.json({message:"Succesfully created and added to history",status:true})
                })
            }
        }).catch(err=>{
            return res.status(500).json({message:"Server error",status:false})
        })
    }


}

export default historyController