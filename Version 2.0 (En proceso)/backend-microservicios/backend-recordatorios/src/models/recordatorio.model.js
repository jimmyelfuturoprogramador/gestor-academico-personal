const { pool } = require('../config/db');

const RecordatorioModel = {
  async listarPorUsuario(idusuario) {
    const { rows } = await pool.query(
      'SELECT * FROM public.recordatorio WHERE idusuario = $1 ORDER BY fechalimite ASC',
      [idusuario]
    );
    return rows;
  },

  async insertar({ idusuario, titulo, descripcion, fechalimite, hora }) {
    const { rows } = await pool.query(
      `INSERT INTO public.recordatorio (idusuario, titulo, descripcion, fechalimite, hora)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING *`,
      [idusuario, titulo, descripcion, fechalimite, hora]
    );
    return rows[0];
  },

  async actualizar({ idrecordatorio, titulo, descripcion, fechalimite, hora, estado }) {
    const { rows } = await pool.query(
      `UPDATE public.recordatorio
       SET titulo = $1, descripcion = $2, fechalimite = $3, hora = $4, estado = $5
       WHERE idrecordatorio = $6
       RETURNING *`,
      [titulo, descripcion, fechalimite, hora, estado, idrecordatorio]
    );
    return rows[0] || null;
  },

  async eliminar(idrecordatorio) {
    await pool.query('DELETE FROM public.recordatorio WHERE idrecordatorio = $1', [idrecordatorio]);
    return true;
  }
};

module.exports = RecordatorioModel;
