---
layout: default
title: Server Info
parent: Node Code
nav_order: 1
---

# Server Info
{: .no_toc }

```js
import express, { json } from 'express';
import cors from 'cors';
import pool from './db.js';

const app = express();
const PORT = process.env.PORT || 3000;
const corsOptions = { origin: process.env.URL || '*', AccessControlAllowOrigin: '*' };

app.use(cors(corsOptions));
app.use(json());

app.get('/', (request, response) => {
    response.json({ info: 'Node.js, Express, and PostgreSQL API' })
})

//GET All Accounts
app.get('/accounts', async (request, response) => {
    try {
        const accts = await pool.query("SELECT * FROM accounts");
        response.status(200).json(accts.rows);
    } catch (error) {
        console.log(error.message);
    }
})

app.listen(PORT, () => {
    console.log(`Server is listening on http://localhost:${PORT}`);
});

```

