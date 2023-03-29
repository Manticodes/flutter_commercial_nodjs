const express = require("express");
const User = require("../model/user");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
authRouter.post(('/api/signup'), async (req, res) => {
    //get data from client
    try {
        const { name, email, password } = req.body;
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "user exist please try ro log in " });
        }
        const hashedPassword = await bcryptjs.hash(password, 8);
        let user = new User({
            email,
            password: hashedPassword,
            name,
        })
        user = await user.save();
        res.json(user);
    } catch (e) {

        res.status(500).json({ error: e.message });
    }



    //send to db
    //return to user


})
module.exports = authRouter;