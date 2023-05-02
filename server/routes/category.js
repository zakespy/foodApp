import express  from "express";
import mongoose from "mongoose";
import categoryModel from "../models/categoryModel.js";
import categoryController from "../controllers/categoryController.js";

const router  = express.Router()

router.get('/getAllCategory',categoryController.getAllCategory)
router.post('/addCategory',categoryController.addCategory)
router.post('/removeCategory',categoryController.deleteCategory)
router.post('/editgory',categoryController.editCategory)
router.post('/editAllMenu',categoryController.addCategory2ToAllMenu)

export default router