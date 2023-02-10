import adminAuthController from '../controllers/auth/adminAuth.js';
import express from 'express'


const router = express.Router();

router.post('/signup',adminAuthController.signup)
router.post('/login',adminAuthController.login)


export default router