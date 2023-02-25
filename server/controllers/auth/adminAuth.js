import adminModel from '../../models/adminModel.js';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken'

class adminAuthController {

    static signup = async (req,res)=>{
        const {emailId,password,name,phoneNo} = req.body
        console.log(req.body)
        await adminModel.findOne({emailId:emailId}).then(async e=>{
            if(e){
                return res.json({message:"Admin already exist",status:false})
            }else{
                console.log(parseInt(process.env.SALT));
                const salt = bcrypt.genSaltSync(parseInt(process.env.SALT));
                console.log(salt)
                console.log(password)
                const hash = bcrypt.hashSync(password,salt)
                const newUser = new adminModel({emailId:emailId,password:hash,name:name,phoneNo:phoneNo})
                await newUser.save().then(e=>{
                    return res.json({message:"successfully signup",status:true,profile:newUser})
                })
                console.log(newUser);
            }
        }).catch(err=>{
            console.log(err)
            // return res.status(500).json({message:"Server error",status:false})
        })
    }

  static login = async (req, res) => { 
    const {emailId,password} = req.body
    console.log(emailId,' ',password)
    await adminModel.findOne({emailId:emailId}).then(async e=>{
        if(bcrypt.compareSync(password,e.password)){
            var privateKey = process.env.PRIVATE_KEY
            // console.log(privateKey)
            var token = jwt.sign(
                {
                    emailId:e.emailId
                }
                ,privateKey
            )
            e.token = token;
            await adminModel.findOneAndUpdate({emailId:emailId},e).then(a=>{
                return res.json({message:"Succesfully login",status:true,user:e})
            }).catch(err=>{return res.json({message:"Login failed",status:false})})
            
        }else{
            return res.json({message:"Incorrect password",status:false})
            // console.log('invalid customer') 
        }
    }).catch(err=>{return res.json({message:"Server error",status:false})})
  };
}

export default adminAuthController;