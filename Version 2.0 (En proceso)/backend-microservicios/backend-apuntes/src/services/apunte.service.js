const Apunte = require('../models/apunte.model');
const Tema = require('../models/tema.model');
const Contenido = require('../models/contenido.model');

async function buildTree(idapunte) {
  const temas = await Tema.listarPorApunte(idapunte);
  const contenidosPorTema = new Map();

  // Pre-cargar contenidos por tema
  for (const t of temas) {
    const conts = await Contenido.listarPorTema(t.idtema);
    contenidosPorTema.set(t.idtema, conts);
  }

  // Índice por idtema
  const mapa = new Map();
  temas.forEach(t => mapa.set(t.idtema, { ...t, contenidos: contenidosPorTema.get(t.idtema) || [], subtemas: [] }));

  // Construcción del árbol
  const raiz = [];
  for (const t of mapa.values()) {
    if (t.idtemapadre) {
      const padre = mapa.get(Number(t.idtemapadre));
      if (padre) padre.subtemas.push(t);
      else raiz.push(t); // huérfano por si acaso
    } else {
      raiz.push(t);
    }
  }
  return raiz;
}

const ApunteService = {
  listarPorIdUsuMat: async (idusumat) => await Apunte.listarPorIdUsuMat(idusumat),
  crear: async (data) => await Apunte.crear(data),
  detalle: async (idapunte) => await Apunte.detalle(idapunte),
  actualizar: async (data) => await Apunte.actualizar(data),
  eliminar: async (idapunte) => await Apunte.eliminar(idapunte),
  arbol: async (idapunte) => await buildTree(idapunte)
};

module.exports = ApunteService;
