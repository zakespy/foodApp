import customerModel from "../models/customerModel.js";

class customerController{
    static getAllDoc = async(req,res)=>{
        try {
            const result  = await customerModel.find({})
            console.log(result)
            res.send(result)
        } catch (err) {
            console.log(err)
        }
    }

    static getProfile = async(req,res)=>{
        try{
            const {id} = req.body
            const result = await customerModel.find({_id:id}).then(e=>{
                if(e){
                    return res.json({profile:e,status:true})
                }else{
                    return res.json({message:"User not found",status:false})
                }
            })
        }catch(err){
            res.status(500).json({message:"Server error",status:false})
        }
    }

}

export default customerController;