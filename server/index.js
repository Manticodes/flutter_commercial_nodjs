
//import express
const express = require('express');
const mongoose = require('mongoose');


//import from other file
const authRouter = require('./routes/auth');

//define parameter
const db = "mongodb://root:tTQkZHCFFUxMiQBfckF1Slj3@flutter-amazone-clone:27017/my-app?authSource=admin";
const PORT = 27017;

//initilize express
//mongodb://root:tTQkZHCFFUxMiQBfckF1Slj3@flutter-amazone-clone:27017/my-app?authSource=admin
//mongodb://root:tTQkZHCFFUxMiQBfckF1Slj3@grace.iran.liara.ir:33161/my-app?authSource=admin

const app = express();




//middleware
app.use(express.json());
app.use(authRouter);


//connect db
mongoose.connect(db, { authSource: "admin" }).then(() => { console.log(` data base connected at port ${PORT}`); }).catch((e) => {
    console.log(e);
});


//create api
app.listen(PORT, "0.0.0.0", () => { console.log("connected at port " + PORT) })
//0.0.0.0 can access from anywhere
//127.0.0.1 local  , if put it empty it gonna be local too