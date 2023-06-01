const mongoose = require("mongoose");
const { productSchema } = require("./product");

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                /*    
            const re =/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/;   
            // const re = /^\S+@\S+\.\S+$/;
           
           */
                const re =
                    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/;

                console.log(
                    "==================> validating email adrress <=================="
                );
                return value.match(re);
            },
            message: "Please enter a valid email address",
        },
    },
    password: {
        required: true,
        type: String,
        /*
            validate :  {
                validator : (value) => {
                    const re =/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\ ]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                
                    return value.length > 6;
                },
                message : 'Please enter a longer paswword',
            },
        */
    },

    address: {
        type: String,
        default: "",
    },
    //you can add seller part here
    type: {
        type: String,
        default: "user",
    },
    imageUrl: {
        type: String,
        default: "",
    },
    // cart
    cart: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                required: true,
            },
        },
    ],

    wishList: [
        {
            product: productSchema,
        },
    ],

    searchHistory: [
        {
            type: String,
        },
    ],
});

const User = mongoose.model("User", userSchema);

module.exports = User;
