import mongoose from "mongoose";
import Razorpay from "razorpay";

import orderModel from "../models/orderModel.js";

import { validatePaymentVerification } from "razorpay/dist/utils/razorpay-utils.js";

export const createOrder = async (req, res) => {
    const { amount } = req.body;
    var instance = new Razorpay( { key_id: 'rzp_test_rk34q3MXaI4tBi', key_secret: 'T5RC8mNXy9yJANYD6QLdEUPH' } );
    var options = {
        amount: amount * 100,
        currency: "INR",
        receipt: "rcpt_id_1",
    };

    
    try {
        let order = await instance.orders.create(options);

        const newOrder = new orderModel({ isPaid: false, amount: amount, order_id: order.id, payment_id: "pay_id", signature: "T5RC8mNXy9yJANYD6QLdEUPH" });

        await newOrder.save();

        res.status(201).json( { success: true, order: order, newOrder: newOrder } );
    } catch (error) {
        res.status(500).json( { message: error.message } );
    }

};

export const verifySignature = async (req, res) => {
    const { order_id, razorpay_payment_id, razorpay_signature } = req.body;

    try {
        const generated_signature = validatePaymentVerification( { "order_id": order_id, "payment_id": razorpay_payment_id }, 
                                    razorpay_signature, "T5RC8mNXy9yJANYD6QLdEUPH" );

        if( generated_signature == true ) {
            res.status(200).json( { message: "Your payment was successfull" } );
        }
        else {
            res.status(200).json( { message: "Your payment failed" } );

        }
    } catch (error) {
        res.status(500).json( { message: error.message } );
    }
};

export const paymentSuccess = async (req, res) => {
    const { order_id } = req.body;

    try {
        const updatedOrder = await orderModel.findOneAndUpdate({ order_id: order_id }, { isPaid: true }, {new:true});

        res.status(200).json( {message: "Your payment was successfull", order: updatedOrder } );
    } catch (error) {
        res.status(500).json({message: error.message});
    }
};