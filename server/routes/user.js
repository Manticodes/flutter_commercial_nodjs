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
        if (product.quantity == 0) {
            return res.status(404).json({ error: 'Product out of stock' });
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
//Todo : first check are cart item that are in stock then loop through cart and 
userRouter.post("/api/order", auth, async (req, res) => {
    try {
        const { cart, totalPrice, address } = req.body;
        let products = [];
        for (let i = 0; i < cart.length; i++) {
            let product = await Product.findById(cart[i].product._id);
            if (!product) {
                return res
                    .status(404)
                    .json({ msg: 'Product not found' });
            }
            if (product.quantity == 0) {
                return res
                    .status(404)
                    .json({ msg: `${product.name} is out of stock!` });
            }
            if (product.quantity < cart[i].quantity) {
                return res
                    .status(400)
                    .json({ msg: `${product.name} is more than stock!` });

            }
        }


        for (let i = 0; i < cart.length; i++) {
            let product = await Product.findById(cart[i].product._id);
            if (product.quantity >= cart[i].quantity) {
                product.quantity -= cart[i].quantity;
                products.push({ product, quantity: cart[i].quantity });
                await product.save();
            } else {
                return res
                    .status(400)
                    .json({ msg: `${product.name} is out of stock!` });
            }
        }

        let user = await User.findById(req.userId);
        user.cart = [];
        user = await user.save();

        let order = new Order({
            products,
            totalPrice,
            address,
            userId: req.userId,
            orderedAt: new Date().getTime(),
        });
        order = await order.save();
        res.json(order);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

userRouter.get('/api/orders/me', auth, async (req, res) => {
    try {
        let orders = await Order.find({ userId: req.userId });
        res.json(orders);
    }

    catch (error) {
        res.status(500).json({ error: error.message });

    }

});


module.exports = userRouter;