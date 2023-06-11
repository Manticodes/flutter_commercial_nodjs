const express = require("express");
const userRouter = express.Router();
const User = require('../model/user');
const auth = require("../middleware/auth");
const { Product } = require("../model/product");
const Order = require("../model/order");


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

userRouter.post('/api/add-address', auth, async (req, res) => {
    try {
        const { userId } = req;
        const { address } = req.body;

        if (!address) {
            return res.status(400).json({ error: 'Address is required' });
        }

        const user = await User.findById(userId);

        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }

        user.address = address;
        await user.save();

        res.json(user);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
userRouter.post("/api/add-order", auth, async (req, res) => {
    try {
        const { cart, totalPrice, address } = req.body;
        const userId = req.userId;
        let user = await User.findById(userId);
        let products = [];





        if (!user) {
            return res.status(404).json({ error: 'User not found' });

        }
        if (!address) {
            return res.status(400).json({ error: 'Address is required' });
        }
        if (!cart || cart.length === 0) {
            return res.status(400).json({ error: 'Cart is required' });
        }
        if (!totalPrice) {
            return res.status(400).json({ error: 'Total price is required' });
        }

        for (let index = 0; index < cart.length; index++) {
            let product = await Product.findById(cart[index].product._id);
            if (!product) {
                return res.status(404).json({ error: 'Product not found' });
            }

            if (product.quantity >= cart[index].quantity) {
                product.quantity -= cart[index].quantity;
                await product.save();
                products.push({
                    product: product,
                    quantity: cart[index].quantity,
                });
            } else { return res.status(400).json({ error: 'Quantity is more than product' }); }
        }
        let order = new Order({
            totalPrice,
            address,
            products,
            orderedDate: Date().getTime(),
            stat,
            userId,
        });
        user.cart = [];
        user = await user.save();
        order = await order.save();
        res.json({ message: 'Order added successfully', order });

    } catch (error) {
        res.status(500).json({ error: error.message });
    }



})









module.exports = userRouter;