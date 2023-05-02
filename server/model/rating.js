const mongoose = require('mongoose');

const ratingSchema = mongoose.Schema({
    userId: {
        type: String,
        required: true,
    },
    rate: {
        type: Number,
        required: true,
    },




});
module.exports = ratingSchema;