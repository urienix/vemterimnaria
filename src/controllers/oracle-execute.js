const oracledb = require('oracledb');
const configs = require('../configs/configs');

let pool = {};

const conectionConfig = {
    user: configs.DB_USER,
    password: configs.DB_PASSWORD,
    connectString: `${configs.DB_HOST}/${configs.DB_INSTANCE}`,
};


/**
  * Esta llamada ejecuta un comando SQL en Oracle.
  * Puede recibir variables de vinculación y devuelve un máximo de 100 líneas de forma predeterminada.
  *
  * @remarks Ejemplo:
  *
  * sql: seleccione * de la tabla donde id_table =: id
  *
  * parámetros: [35295]
  *
  * maxRows: 10 // limita el retorno a 10 filas.
  *
  * @param {cadena} sql El comando SQL a ejecutar.
  * @param {Object|Array<any>} params Un objeto/matriz con las variables de vinculación.
  * @param {number} maxRows Número máximo de filas devueltas. Predeterminado: 100.
  * @param {string} poolAlias ​​​​Alias ​​​​para la conexión de la base de datos (si es diferente de la predeterminada).
  * @returns Un resultado que contiene las filas devueltas.
  */ 
pool.query = async (sql, params = [], maxRows = 100) => {
    let conn;
    try {
        conn = await oracledb.getConnection(conectionConfig);
        const result = await conn.execute(
            sql,
            params, {
                outFormat: oracledb.OBJECT,
                maxRows,
            },
        );
        return result.rows;
    } catch (e) {
        e.messsage = e;
        throw e;
    } finally {
        if (conn) {
            await conn.close();
        }
    }
};

/**
  * Esta llamada ejecuta un Procedimiento en Oracle.
  *
  * @observaciones Ejemplo:
  *
  * sql: testproc(:i, :io, :o)
  *
  * bindvars:
  * {
  * i: req.param.name,
  * io: {val: req.body.lastname, dir: db.oracledb.BIND_INOUT},
  * o: { type: db.oracledb.NUMBER, dir: db.oracledb.BIND_OUT }
  * }
  * @param {string} nombre del procedimiento sql y sus parámetros de entrada, salida o entrada y salida.
  * @param {Object|Array<any>} bindvars Un objeto/matriz con las variables de vinculación IN, OUT o IN OUT.
  * @param {string} poolAlias ​​​​Alias ​​​​para la conexión de la base de datos (si es diferente de la predeterminada).
  * @returns Un resultado que contiene los valores de cualquier variable de vinculación OUT e IN OUT.
  */ 
pool.procedure = async (sql, bindvars) => {
    let conn;
    try {
        conn = await oracledb.getConnection(conectionConfig);
        const result = await conn.execute(
            `BEGIN ${sql}; END;`,
            bindvars,
        );
        return result.outBinds;
    } catch (e) {
        e.messsage = e;
        throw e;
    } finally {
        if (conn) {
            await conn.close();
        }
    }
};

module.exports = pool;