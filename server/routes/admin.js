const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");
const Order = require("../models/order");
// adding product
// you can add all the middlewares here just add them by commas in post method
adminRouter.post("/admin/add-product", admin, async (req, res) => {
    try {
        const {
            name,
            description,
            brandName,
            images,
            quantity,
            price,
            category,
        } = req.body;

        // using let so that it can be changed later
        let product = new Product({
            name,
            description,
            brandName,
            images,
            quantity,
            price,
            category,
        });

        //saving to the DB
        product = await product.save();
        res.json(product);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

// get all products
// api /admin/get-products

adminRouter.get("/admin/get-products", admin, async (req, res) => {
    try {
        const products = await Product.find({});
        // return products to client

        res.json(products);
        zz;
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// delete product
adminRouter.post("/admin/delete-product", admin, async (req, res) => {
    try {
        const { id } = req.body;

        let product = await Product.findByIdAndDelete(id);

        // no need to save it will be done by findByIdAndDelete()
        // product = await product.save();
        res.json(product);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

// change status
adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
    try {
        const { id, status } = req.body;

        let order = await Order.findById(id);
        order.status = status;
        order = await order.save();
        // no need to save it will be done by findByIdAndDelete()
        // product = await product.save();
        res.json(order);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

//
adminRouter.get("/admin/get-orders", admin, async (req, res) => {
    try {
        const orders = await Order.find({});
        res.json(orders);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// get order details and sales analysis

adminRouter.get("/admin/analytics", admin, async (req, res) => {
    try {
        const orders = await Order.find({});
        let totalEarnings = 0;

        for (let i = 0; i < orders.length; i++) {
            for (let j = 0; j < orders[i].products.length; j++) {
                totalEarnings +=
                    orders[i].products[j].quantity *
                    orders[i].products[j].product.price;
            }
        }

        // Category wise order fetching
        let mobileEarnings = await fetchCategoryWiseProducts("Mobiles");
        let essentialsEarnings = await fetchCategoryWiseProducts("Essentials");
        let appliancesEarnings = await fetchCategoryWiseProducts("Appliances");
        let booksEarnings = await fetchCategoryWiseProducts("Books");
        let fashionEarnings = await fetchCategoryWiseProducts("Fashion");

        let earnings = {
            totalEarnings,
            mobileEarnings,
            essentialsEarnings,
            appliancesEarnings,
            booksEarnings,
            fashionEarnings,
        };

        res.json(earnings);
    } catch (e) {
        res.status(500).json({
            error: `Analytics get request error : ${e.message}`,
        });
    }
});

async function fetchCategoryWiseProducts(category) {
    let earnings = 0;
    let categoryOrders = await Order.find({
        "products.product.category": category,
    });

    for (let i = 0; i < categoryOrders.length; i++) {
        for (let j = 0; j < categoryOrders[i].products.length; j++) {
            earnings +=
                categoryOrders[i].products[j].quantity *
                categoryOrders[i].products[j].product.price;
        }
    }
    return earnings;
}

// do not forget to export adminRouter!
module.exports = adminRouter;
