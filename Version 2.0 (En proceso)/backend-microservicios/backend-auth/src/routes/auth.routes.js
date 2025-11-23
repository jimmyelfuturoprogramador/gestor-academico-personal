const { Router } = require('express');
const AuthController = require('../controllers/auth.controller');

const router = Router();

// Rutas públicas
router.post('/register', AuthController.register);
router.post('/login', AuthController.login);

// Rutas protegidas
router.get('/me', AuthController.authMiddleware, AuthController.me);

module.exports = router;
