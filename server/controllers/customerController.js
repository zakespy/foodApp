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

}

export default customerController;