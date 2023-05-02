import mongoose from "mongoose";

import dayOrderModel from "../models/dayOrderModel.js";

export const addOrder = async (req, res) => {
    const { tokenNo, orderDetails } = req.body;
    let currentDate = new Date().toJSON().slice(0, 10);

    try {
        let dateOrders = await dayOrderModel.findOne({ dayDate: currentDate });
        console.log(dateOrders);
    } catch (error) {
        res.status(500).json( { message: error.message } );
    }
}