const bcrypt = require('bcryptjs');
const Usuario = require('../models/usuario.model');

const UsuarioService = {
  async registrar({ nombre, apellido, correo, contrasena }) {
    const existente = await Usuario.findByCorreo(correo);
    if (existente) {
      const error = new Error('El correo ya está registrado');
      error.status = 409;
      throw error;
    }
    const contrasenaHash = await bcrypt.hash(contrasena, 10);
    return await Usuario.create({ nombre, apellido, correo, contrasenaHash });
  },

  async validarCredenciales({ correo, contrasena }) {
    const user = await Usuario.findByCorreo(correo);
    if (!user) return null;
    const ok = await bcrypt.compare(contrasena, user.contrasena);
    if (!ok) return null;
    return user;
  },

  async perfil(idusuario) {
    return await Usuario.findById(idusuario);
  },

  async actualizar(datos) {
    return await Usuario.update(datos);
  },

  async eliminar(idusuario) {
    return await Usuario.delete(idusuario);
  }
};

module.exports = UsuarioService;
