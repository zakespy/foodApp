import express from "express";

import { addOrder } from "../controllers/dayOrderController.js";

const router = express.Router();

router.post("/addDayOrder", addOrder);

export default router;
