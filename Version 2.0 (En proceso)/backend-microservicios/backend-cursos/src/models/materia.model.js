const { pool } = require('../config/db');

const MateriaModel = {
  async listar() {
    const { rows } = await pool.query('SELECT * FROM public.materia ORDER BY idmateria ASC');
    return rows;
  },

  async buscarPorId(idmateria) {
    const { rows } = await pool.query(
      'SELECT * FROM public.materia WHERE idmateria = $1 LIMIT 1',
      [idmateria]
    );
    return rows[0] || null;
  }
};

module.exports = MateriaModel;
