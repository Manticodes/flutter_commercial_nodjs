const express = require("express");
const userRouter = express.Router();
const User = require('../model/user');
const auth = require("../middleware/auth");
const { productSchema } = require("../model/products");
const { Product } = require("../model/product");

userRouter.post('/cart/add-product', auth, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.userId);
        if (user.cart.length == 0) {
            user.cart.push({ product, quantity: 1 });

        } else {
            let isProductFound = false;
            for (let index = 0; index < user.cart.length; index++) {
                if (user.cart[i].product._id.equals(product._id)) {
                    isProductFound = true;

                }

            }
            if (isProductFound) {
                let cartItem = user.cart.find((pr) => pr.product._id.equals(product._id));
                cartItem.product += 1;

            } else {
                user.cart.push({ product, quantity: 1 });

            }


        }
        user = await this.user.save();
        res.json(user);

    } catch (error) {
        res.status(500).json({ error: error.message });

    }

});






module.exports = userRouter;