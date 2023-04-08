const express = require("express");
const User = require("../model/user");
const bcryptjs = require("bcryptjs");
const jwt = require('jsonwebtoken');
const auth = require("../middleware/auth");
const authRouter = express.Router();


//get data from client
authRouter.post(('/api/signup'), async (req, res) => {

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
});


//sign in 
authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        const existingUser = await User.findOne({ email });
        if (!existingUser) {
            return res.status(400).json({ msg: "User does not exist" })
        }
        const isMatch = await bcryptjs.compare(password, existingUser.password)
        if (!isMatch) {
            return res.status(400).json({ msg: "Wrong Password" })
        }
        const token = jwt.sign({ id: existingUser._id }, "passwordKey");
        res.json({ token, ...existingUser._doc });
    } catch (error) {
        res.status(500).json({ error: e.message });
    }
});



//validToken
authRouter.post('/api/validtoken', async (req, res) => {
    try {
        const token = req.header('x-auth-token',);
        if (!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.json(false);
        const user = User.findById(verified.id);
        if (!user) return res.json(false);
        res.json(true);



    } catch (error) {
        res.status(500).json({ error: e.message });
    }
});
authRouter.get('/api/getuser', auth, async (req, res) => {
    const user = await User.findById(req.userId);
    res.json({ ...user._doc, token: req.token });


})



module.exports = authRouter;