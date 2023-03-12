import customerController from "../controllers/customerController.js";
import express from 'express'
import customerAuthController from "../controllers/auth/customerAuth.js";

const router = express.Router();

router.post('/signup',customerAuthController.signup)
router.post('/login',customerAuthController.login)
router.post('/profile',customerController.getProfile)
router.get('/allCustomer',customerController.getAllDoc)



export default router