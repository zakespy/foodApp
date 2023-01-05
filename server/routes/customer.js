import customerController from "../controllers/customerController.js";
import express from 'express'

const router = express.Router();

router.get('/allCustomer',customerController.getAllDoc)

export default router