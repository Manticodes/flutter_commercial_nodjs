const mongoose = require('mongoose');
const { productSchema } = require('./product');

const userScheman = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        requierd: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re =
                    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);


            },
            message: "Please Enter valid Email"

        }

    },
    password: {
        requierd: true,
        type: String
    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    },
    cart: [
        {
            product: productSchema,
            quantity: {

                type: Number,
                required: true,
            }

        }

    ]

});

const User = mongoose.model("User", userScheman);
module.exports = User;