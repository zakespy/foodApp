import mongoose from "mongoose";

import dayOrderModel from "../models/dayOrderModel.js";

export const addOrder = async (req, res) => {
    const { tokenNo, orderDetails } = req.body;
    let currentDate = new Date().toJSON().slice(0, 10);

    try {
        let dateOrdersDetails = await dayOrderModel.findOne({ dayDate: currentDate });
        // console.log(dateOrdersDetails);

        if( dateOrdersDetails == null ){
            const dateOrder = new dayOrderModel({ dayDate: currentDate, order:[{ tokenNumber: tokenNo, orderDetails: orderDetails }] });

            await dateOrder.save();
// console.log(1)
            res.status(201).json( { success: true, newDetailList: dateOrder } );
        }
        else{
            const dateOrder = await dayOrderModel.findOne({ dayDate: currentDate });

            dateOrder.order.push({ tokenNumber: tokenNo, orderDetails: orderDetails });

            await dayOrderModel.findOneAndUpdate({ dayDate: currentDate }, { order: dateOrder.order });
// console.log(2)
            res.status(201).json( { success: true, newDetailList: dateOrder } );
        }
    } catch (error) {
        res.status(500).json( { message: error.message } );
    }
}