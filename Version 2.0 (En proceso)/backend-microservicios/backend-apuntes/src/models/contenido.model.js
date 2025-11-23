const { pool } = require('../config/db');

const ContenidoModel = {
  async listarPorTema(idtema) {
    const { rows } = await pool.query(
      'SELECT * FROM public.contenido WHERE idtema = $1 ORDER BY idcontenido ASC',
      [idtema]
    );
    return rows;
  },

  async crear({ idtema, texto }) {
    const { rows } = await pool.query(
      `INSERT INTO public.contenido (idtema, texto)
       VALUES ($1, $2)
       RETURNING *`,
      [idtema, texto]
    );
    return rows[0];
  },

  async actualizar({ idcontenido, texto }) {
    const { rows } = await pool.query(
      `UPDATE public.contenido
       SET texto = $1
       WHERE idcontenido = $2
       RETURNING *`,
      [texto, idcontenido]
    );
    return rows[0] || null;
  },

  async eliminar(idcontenido) {
    await pool.query('DELETE FROM public.contenido WHERE idcontenido = $1', [idcontenido]);
    return true;
  }
};

module.exports = ContenidoModel;
