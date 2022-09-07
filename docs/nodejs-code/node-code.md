---
layout: default
title: Node Code
nav_order: 9
has_children: true
permalink: /docs/node-code
---

# Node Code

{: .fs-6 .fw-300 }

These codes will be used to deploy the server onto Heroku.
The prerequisites are that you have enabled the PostgreSQL add-on for your app.

Make sure to fill these in with the correct data that you get once you are done creating your app on heroku.

```bash
    $ psql --host=aaa-bb-cc-xxx-yy.compute-1.amazonaws.com --port=5432 --username=xxxxxxxxxx --password --dbname=xxxxxxxxxx
```

This will create the table and add a test account to the table that was just created.

```bash
    $ heroku pg:psql --app app-name postgresql-something-11111 < setup.sql
```