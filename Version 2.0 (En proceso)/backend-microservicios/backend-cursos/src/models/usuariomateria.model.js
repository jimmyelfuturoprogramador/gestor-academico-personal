const { pool } = require('../config/db');

const UsuarioMateriaModel = {
  async listarPorUsuario(idusuario) {
    const { rows } = await pool.query(
      `SELECT um.idusumat, m.nombremateria, m.cursoparalelo, m.nombredocente, m.imagenurl
       FROM public.usuariomateria um
       INNER JOIN public.materia m ON um.idmateria = m.idmateria
       WHERE um.idusuario = $1 AND um.estado = 'Activo'
       ORDER BY um.idusumat`,
      [idusuario]
    );
    return rows;
  },

  async inscribir({ idusuario, idmateria }) {
    const { rows } = await pool.query(
      `INSERT INTO public.usuariomateria (idusuario, idmateria)
       VALUES ($1, $2)
       RETURNING *`,
      [idusuario, idmateria]
    );
    return rows[0];
  },

  async buscarInscripcion(idusuario, idmateria) {
    const { rows } = await pool.query(
      `SELECT * FROM public.usuariomateria
       WHERE idusuario = $1 AND idmateria = $2`,
      [idusuario, idmateria]
    );
    return rows[0] || null;
  },

  async desinscribir(idusumat) {
    await pool.query('DELETE FROM public.usuariomateria WHERE idusumat = $1', [idusumat]);
    return true;
  }
};

module.exports = UsuarioMateriaModel;
