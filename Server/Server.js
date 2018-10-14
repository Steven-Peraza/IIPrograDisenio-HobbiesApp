const express = require('express');
const app = express();
const http = require('http').Server(app);

var routes = require("./api/routes");

const port = 3000;


app.use(express.json())
app.use(cors())
routes(app)

http.listen(port, () => console.info(`REST API running on port ${port}`));