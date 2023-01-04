import customerModel from "../models/customerModel.js";

class customerController{
    static getAllDoc = async(req,res)=>{
        try {
            const result  = await customerModel.find({emailId:"satyam.ms@somaiya.edu"})
            console.log(result)
            res.send(result)
        } catch (err) {
            console.log(err)
        }
    }
}

export default customerController;