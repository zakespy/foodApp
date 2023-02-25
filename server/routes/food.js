import express from "express";
import foodModel from "../models/foodModel.js";
import foodController from "../controllers/foodController.js";

const router = express.Router()

router.get('/allFood',foodController.getMenu)
router.get('/getFood',foodController.getFood)
router.post('/addFood',foodController.addFood)
router.post('/removeFood',foodController.removeFood)
router.post('/updateFood',foodController.editFood)
router.get('/getFoodCategory',foodController.getFoodCategory)
router.post('/addCategory',foodController.addCategory)
router.post('/deleteCategory',foodController.deleteCategory)

export default router

