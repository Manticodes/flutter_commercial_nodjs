const express = require("express");
const User = require("../model/user");
const authRouter = express.Router();
authRouter.post(('/api/signup'), async (req, res) => {
    //get data from client
    try {
        const { name, email, password } = req.body;
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "user exist" });
        }
        let user = new User({
            email,
            password,
            name,
        })
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ eror: e.message });
    }



    //send to db
    //return to user


})
module.exports = authRouter;