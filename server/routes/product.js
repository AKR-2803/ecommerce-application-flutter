// //fetch all the products of a particular category

// const express = require("express");
// const productRouter = express.Router();
// const auth = require("../middlewares/auth");
// const { Product } = require("../models/product");

// // --> /api/products?category=Essentials
// // --> /api/amazon?theme=dark
// //use ? for query
// productRouter.get("/api/products", auth, async (req, res) => {
//     try {
//         console.log(`Category request ==>  ${req.query.category}`);
//         const products = await Product.find({ category: req.query.category });
//         res.json(products);
//     } catch (e) {
//         res.status(500).json({ error: e.message });
//     }
// });

// //create new get request to search products and get them

// productRouter.get("/api/products/search/:name", auth, async (req, res) => {
//     try {
//         // console.log(`Category request ==>  ${req.query.category}`);
//         const products = await Product.find({
//             name: { $regex: req.params.name, $options: "i" },
//         });
//         res.json(products);
//     } catch (e) {
//         res.status(500).json({ error: e.message });
//     }
// });

// //create new post request to rate the products

// productRouter.post("/api/rate-product", auth, async (req, res) => {
//     try {
//         //product id and rating
//         const { id, rating } = req.body;

//         let product = await Product.findById(id);

//         //cheching from all reviews is same user has reviewed it again
//         //then overwrite the his old review with new one
//         for (let i = 0; product.ratings.length; i++) {
//             //check if user has already reviewd the product
//             if (product.ratings[i].userId == req.user) {
//                 //removing the old review
//                 product.ratings.splice(i, 1);
//                 break;
//             }
//         }

//         const ratingSchema = {
//             userId: req.user,
//             rating,
//         };
//         //same thing
//         // const ratingSchema = {
//         //     userId: req.user,
//         //     rating: rating,
//         // };

//         product.ratings.push(ratingSchema);
//         product = await product.save();
//         res.json(product);
//     } catch (e) {
//         return res
//             .status(500)
//             .json({ error: `Error in rating product:  ${e.messsage}` });
//     }
// });

const express = require("express");
const productRouter = express.Router();
const auth = require("../middlewares/auth");
const { Product } = require("../models/product");
const User = require("../models/user");

productRouter.get("/api/products/", auth, async (req, res) => {
    try {
        const products = await Product.find({ category: req.query.category });
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// create a get request to search products and get them
// /api/products/search/i
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
    try {
        const products = await Product.find({
            name: { $regex: req.params.name, $options: "i" },
        });

        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// create a post request route to rate the product
productRouter.post("/api/rate-product", auth, async (req, res) => {
    try {
        const { id, rating } = req.body;
        let product = await Product.findById(id);

        for (let i = 0; i < product.ratings.length; i++) {
            if (product.ratings[i].userId == req.user) {
                product.ratings.splice(i, 1);
                break;
            }
        }

        const ratingSchema = {
            userId: req.user,
            rating,
        };

        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// get request for deal-of-the-day

productRouter.get("/api/deal-of-day", auth, async (req, res) => {
    try {
        let products = await Product.find({});

        products = products.sort((a, b) => {
            let aSum = 0;
            let bSum = 0;

            for (let i = 0; i < a.ratings.length; i++) {
                aSum += a.ratings[i].rating;
            }

            for (let i = 0; i < b.ratings.length; i++) {
                bSum += b.ratings[i].rating;
            }
            return aSum < bSum ? 1 : -1;
        });

        res.json(products[0]);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// get all Porducts available

productRouter.get("/api/get-all-products-names", auth, async (req, res) => {
    try {
        const products = await Product.find({});
        let productNames = [];
        // return products to client
        for (let i = 0; i < products.length; i++) {
            productNames[i] = products[i].name;
        }
        res.json(productNames);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

productRouter.get("/api/get-user-of-product", auth, async (req, res) => {
    try {
        // const { id } = req.body;
        let product = await Product.findById({ id: req.body });
        // // let rating = product.ratings;
        let usersList = [];
        for (let i = 0; i < product.ratings.length; i++) {
            let userExist = await User.findById(product.ratings[i].userId);

            usersList.push(userExist);
        }

        /* 
        
         for (let i = 0; i < product.ratings.length; i++) {
            if (product.ratings[i].userId == req.user) {
                product.ratings.splice(i, 1);
                break;
            }
        }
        
        */

        res.json(usersList);
    } catch (e) {
        res.status(500).json({
            error: `Error in getting userID via ratings :  ${e.message}`,
        });
    }
});

module.exports = productRouter;
