import customerController from "../controllers/customerController.js";
import express from 'express'

const router = express.Router();

router.get('/customer',customerController.getAllDoc)

export default router