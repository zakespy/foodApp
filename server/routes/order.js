import  express  from "express";
import orderController from "../controllers/orderController.js";
const router = express.Router();

router.post('/createToken',orderController.createToken)

export default router