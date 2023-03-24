
//import express
const express = require('express');
const mongoose = require('mongoose');
//initilize express
const PORT = 27017;
const app = express();
const db = "mongodb://root:tTQkZHCFFUxMiQBfckF1Slj3@grace.iran.liara.ir:33161/my-app?authSource=admin";

//import from other file
const authRouter = require('./routes/auth');


//middleware
app.use(express.json());
app.use(authRouter);


//connect db
mongoose.connect(db, { authSource: "admin" }).then(() => { console.log(` data base connected at port ${PORT}`); }).catch((e) => {
    console.log(e);
});


//create api
app.listen(PORT, () => { console.log("connected at port " + PORT) })
//0.0.0.0 can access from anywhere
//127.0.0.1 local  , if put it emty it gonna be local too