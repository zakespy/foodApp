// import dayOrderModel from "../models/dayOrderModel.js";
// import ongoingOrderModel from "../models/ongoingOrder.js";
import Queue from 'bull' 
import Agenda from 'agenda';
const mongoConnectionString = 'mongodb+srv://zakespy:Exodus%40123@cluster0.8kk4kls.mongodb.net/foodApp?retryWrites=true&w=majority';

const agenda = new Agenda({ db: { address: mongoConnectionString } });


class orderController{

    static createToken = async (req,res)=>{
        agenda.define('myJob', (job, done) => {
            console.log(job)
            console.log('Running myJob');
            done();
          });
          
          agenda.start();
       
    }

}

export default orderController