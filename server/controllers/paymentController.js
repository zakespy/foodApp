import Razorpay from "razorpay";

export const createOrder = async (req, res) => {

    var instance = new Razorpay( { key_id: 'rzp_test_rk34q3MXaI4tBi', key_secret: 'T5RC8mNXy9yJANYD6QLdEUPH' } );
    var options = {
        amount: 100,
        currency: "INR",
        receipt: "rcpt_id_1",
    };

    
    try {
        let order = await instance.orders.create(options);

        res.status(201).json( { success: true, order: order } );
    } catch (error) {
        res.status(500).json( { message: error.message } );
    }

};