import  express  from "express";
import orderController from "../controllers/orderController.js";
const router = express.Router();

router.post('/createToken',orderController.createToken)
router.post('/addOrder',orderController.createOnGoingOrder)
router.post('/deleteOrder',orderController.deleteOnGoingOrder)
router.post('/removeOrder',orderController.removeOngoingOrder)

export default router 