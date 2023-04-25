const express = require("express");
const productRouter = express.Router();
const Product = require('../model/product');
const auth = require("../middleware/auth");


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




module.exports = productRouter;