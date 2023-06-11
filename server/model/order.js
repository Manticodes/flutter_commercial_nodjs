
const mongoose = require('mongoose');
const { productSchema } = require('./product');

const orderSchema = new mongoose.Schema({
    totalPrice: {
        type: Number,
        required: true,
        validate: {
            validator: function (v) {
                return v >= 0;
            },
            message: "Price should be a positive number"
        }
    },
    products: [{
        product: productSchema,
        quantity: {
            type: Number,
            required: true
        },
    }],
    address: {
        type: String,
        required: true

    },
    userId: {
        required: true,
        type: String,
    },
    orderedDate: {
        type: Number,
        required: true,
    },
    status: {
        type: Number,
        default: 0,
    },

});

const Order = mongoose.model('Order', orderSchema);
module.exports = Order;
