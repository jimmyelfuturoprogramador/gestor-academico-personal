const UsuarioMateria = require('../models/usuariomateria.model');

const UsuarioMateriaService = {
  listarPorUsuario: async (idusuario) => {
    return await UsuarioMateria.listarPorUsuario(idusuario);
  },

  inscribir: async ({ idusuario, idmateria }) => {
    const existe = await UsuarioMateria.buscarInscripcion(idusuario, idmateria);
    if (existe) throw new Error('El usuario ya está inscrito en esta materia.');
    return await UsuarioMateria.inscribir({ idusuario, idmateria });
  },

  desinscribir: async (idusumat) => {
    return await UsuarioMateria.desinscribir(idusumat);
  }
};

module.exports = UsuarioMateriaService;
