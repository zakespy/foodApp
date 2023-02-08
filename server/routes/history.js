import express  from "express";
import historyModel from "../models/historyModel.js";
import historyController from "../controllers/historyController.js";

const router = express.Router()

router.get('/getHistory',historyController.getHistory)
router.post('/addHistory',historyController.addHistory)

export default router