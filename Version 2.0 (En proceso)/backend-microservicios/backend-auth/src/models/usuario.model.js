const { pool } = require('../config/db');

const UsuarioModel = {
  async findByCorreo(correo) {
    const { rows } = await pool.query(
      'SELECT * FROM public.usuario WHERE correo = $1 LIMIT 1',
      [correo]
    );
    return rows[0] || null;
  },

  async findById(idusuario) {
    const { rows } = await pool.query(
      'SELECT idusuario, nombre, apellido, correo, estado, fecharegistro FROM public.usuario WHERE idusuario = $1',
      [idusuario]
    );
    return rows[0] || null;
  },

  async create({ nombre, apellido, correo, contrasenaHash }) {
    const { rows } = await pool.query(
      `INSERT INTO public.usuario (nombre, apellido, correo, contrasena)
       VALUES ($1, $2, $3, $4) RETURNING idusuario, nombre, apellido, correo, estado, fecharegistro`,
      [nombre || null, apellido || null, correo, contrasenaHash]
    );
    return rows[0];
  },

  async update({ idusuario, nombre, apellido, correo, contrasenaHash }) {
    const { rows } = await pool.query(
      `UPDATE public.usuario
       SET nombre = $1, apellido = $2, correo = $3, contrasena = COALESCE($4, contrasena)
       WHERE idusuario = $5
       RETURNING idusuario, nombre, apellido, correo, estado, fecharegistro`,
      [nombre || null, apellido || null, correo, contrasenaHash || null, idusuario]
    );
    return rows[0] || null;
  },

  async delete(idusuario) {
    await pool.query('DELETE FROM public.usuario WHERE idusuario = $1', [idusuario]);
    return true;
  }
};

module.exports = UsuarioModel;
