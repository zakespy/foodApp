import express from "express";

import { createOrder, verifySignature, paymentSuccess } from "../controllers/paymentController.js";

const router = express.Router();

router.post("/createOrder", createOrder);
router.post("/verifySignature", verifySignature);
router.post("/paymentSuccess", paymentSuccess);

export default router;