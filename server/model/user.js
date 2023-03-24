const mongoose = requierd('mongoose');

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


            }
        }

    }
})