const express = require("express");
const authRouter = express.Router();
authRouter.post(('/api/signup'), (req, res) => {
    //get data from client
    const { name, email, pass } = req.body;

    //send to db
    //return to user


})
module.exports = authRouter;