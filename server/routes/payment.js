import express from "express";

import { createOrder, verifySignature } from "../controllers/paymentController.js";

const router = express.Router();

router.post("/createOrder", createOrder);
router.post("/verifySignature", verifySignature);

export default router;