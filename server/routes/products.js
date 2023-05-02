const express = require("express");
const productRouter = express.Router();
const Product = require('../model/product');
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

productRouter.get('/api/rate-products', auth, async (req, res) => {
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
            userId: req.user,
            rate: rating,
        };
        product.ratings.push(ratingSchema);
        product = await product.save;
        res.json(product);

    } catch (error) {
        res.status(500).json({ error: error.message })
    }
});



module.exports = productRouter;