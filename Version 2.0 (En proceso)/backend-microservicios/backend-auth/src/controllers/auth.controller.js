const jwt = require('jsonwebtoken');
const UsuarioService = require('../services/usuario.service');

function emitirToken(user) {
  const payload = { idUsuario: user.idusuario, correo: user.correo };
  return jwt.sign(payload, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES || '8h'
  });
}

function authMiddleware(req, res, next) {
  // Permite al Gateway omitir si ya validó; pero útil si pegas directo al servicio
  const auth = req.headers.authorization || '';
  const token = auth.startsWith('Bearer ') ? auth.slice(7) : null;
  if (!token) return res.status(401).json({ error: 'Token requerido' });
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next();
  } catch {
    return res.status(401).json({ error: 'Token inválido' });
  }
}

const AuthController = {
  async register(req, res, next) {
    try {
      const { nombre, apellido, correo, contrasena } = req.body || {};
      if (!correo || !contrasena) return res.status(400).json({ error: 'correo y contrasena son obligatorios' });
      const user = await UsuarioService.registrar({ nombre, apellido, correo, contrasena });
      const token = emitirToken(user);
      res.status(201).json({ user, token });
    } catch (err) {
      next(err);
    }
  },

  async login(req, res, next) {
    try {
      const { correo, contrasena } = req.body || {};
      if (!correo || !contrasena) return res.status(400).json({ error: 'correo y contrasena son obligatorios' });

      const user = await UsuarioService.validarCredenciales({ correo, contrasena });
      if (!user) return res.status(401).json({ error: 'Credenciales inválidas' });

      const perfil = await UsuarioService.perfil(user.idusuario);
      const token = emitirToken(user);
      res.json({ user: perfil, token });
    } catch (err) {
      next(err);
    }
  },

  async me(req, res, next) {
    try {
      const id = req.user?.idUsuario;
      const perfil = await UsuarioService.perfil(id);
      res.json({ user: perfil });
    } catch (err) {
      next(err);
    }
  },

  authMiddleware
};

module.exports = AuthController;
