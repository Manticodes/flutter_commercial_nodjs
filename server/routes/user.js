const express = require("express");
const userRouter = express.Router();
const User = require('../model/user');
const auth = require("../middleware/auth");
const { Product } = require("../model/product");

/* userRouter.post('/cart/add-product', auth, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.userId);
        if (user.cart.length == 0) {
            user.cart.push({ product, quantity: 1 });

        } else {
            let isProductFound = false;
            for (let index = 0; index < user.cart.length; index++) {
                if (user.cart[index].product._id.equals(product._id)) {
                    isProductFound = true;
                }

            }
            if (isProductFound) {
                let cartItem = user.cart.find((pr) => pr.product._id.equals(product._id));
                cartItem.quantity += 1;

            } else {
                user.cart.push({ product, quantity: 1 });
            }


        }
        user = await user.save();
        res.json(user);

    } catch (error) {
        res.status(500).json({ error: error.message });

    }

}); */
userRouter.post('/cart/add-product', auth, async (req, res) => {
    try {
        const productId = req.body.id;

        // Check if product exists
        const product = await Product.findById(productId);
        if (!product) {
            return res.status(404).json({ error: 'Product not found' });
        }

        // Check if user exists
        const userId = req.userId;
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }

        let isProductFound = false;
        for (let index = 0; index < user.cart.length; index++) {
            if (user.cart[index].product._id.equals(productId)) {
                isProductFound = true;
                user.cart[index].quantity += 1;
                break;
            }
        }

        if (!isProductFound) {
            user.cart.push({ product, quantity: 1 });
        }

        await user.save();
        res.json(user);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userRouter.get('/cart/check-product', auth, async (req, res) => {
    try {
        let product = await Product.findById(req.query.id);
        if (product == null) {
            res.json(
                false
            )
        } else {
            res.json(
                true)

        }



    } catch (error) {
        res.status(500).json({ error: error.message });

    }
});

userRouter.post('/cart/remove-product', auth, async (req, res) => {
    try {
        const productId = req.body.id;

        // Check if product exists
        const product = await Product.findById(productId);
        if (!product) {
            return res.status(404).json({ error: 'Product not found' });
        }

        // Check if user exists
        const userId = req.userId;
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }


        for (let index = 0; index < user.cart.length; index++) {
            if (user.cart[index].product._id.equals(productId)) {

                if (user.cart[index].quantity == 1) {
                    user.cart.splice(index, 1);
                    break;
                } else {
                    user.cart[index].quantity -= 1;
                    break;

                }
            }
        }

        await user.save();
        res.json(user);

    } catch (error) {
        res.status(500).json({ error: error.message });

    }
});






module.exports = userRouter;