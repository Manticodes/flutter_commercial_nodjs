const express = require("express");
const productRouter = express.Router();
const { Product } = require('../model/product');
const auth = require("../middleware/auth");
const ratingSchema = require("../model/rating");


productRouter.get('/api/get-products', auth, async (req, res) => {
    try {

        const products = await Product.find({ category: req.query.category });
        res.json(products);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


productRouter.get('/api/get-products/search/:name', auth, async (req, res) => {
    try {

        const products = await Product.find({ name: { $regex: req.params.name, $options: "i" }, });
        res.json(products);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

productRouter.post('/api/rate-products', auth, async (req, res) => {
    try {
        const { id, rating } = req.body;
        let product = await Product.findById(id);
        for (let i = 0; i < product.ratings.length; i++) {
            if (product.ratings[i].userId == req.userId) {

                product.ratings.splice(i, 1);
                break;
            }
        }

        const ratingSchema = {
            userId: req.userId,
            rate: rating,
        };
        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);

    } catch (error) {
        res.status(500).json({ error: error.message })
    }
});

productRouter.get('/api/get-deals', auth, async (req, res) => {
    try {

        let products = await Product.find({});
        products = products.sort((a, b) => {
            let aSum = 0;
            let bSum = 0;
            for (let index = 0; index < a.ratings.length; index++) {
                aSum += a.ratings[index].rate;

            }
            for (let index = 0; index < b.ratings.length; index++) {
                bSum += b.ratings[index].rate;

            }
            return aSum < bSum ? 1 : -1;
        })
        res.json(products);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
productRouter.get('/api/get-all-products', auth, async (req, res) => {
    try {

        const products = await Product.find({});
        res.json(products);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});





module.exports = productRouter;