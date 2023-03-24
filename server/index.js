console.log("Hello, World")

//import express
const express = require('express');

const PORT = 3000;


//initilize express
const app = express();

//create api
app.listen(PORT, "0.0.0.0", () => { console.log("connected at port " + PORT + ' hello') })
//0.0.0.0 can access from anywhere
//127.0.0.1 local  , if put it emty it gonna be local too