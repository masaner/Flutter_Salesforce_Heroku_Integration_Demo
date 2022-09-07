import pg from 'pg';
const { Pool } = pg;

const poolConfig = process.env.DATABASE_URL ?
  {
    connectionString: process.env.DATABASE_URL,
    ssl: {
      rejectUnauthorized: false,
    }
  }
  :
  {
    user: 'xxxxxxxxxx',
    host: 'aaa-bb-cc-xxx-yy.compute-1.amazonaws.com',
    database: 'xxxxxxxxxx',
    password: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
    port: 5432,
    ssl: {
      ssl: true,
      rejectUnauthorized: false,
    }
  };

const pool = new Pool(poolConfig);
export default pool;