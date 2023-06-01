//MongoDB
//username : akr2803
//pwd      : rajput?283

// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");

// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

const PORT = process.env.PORT || 3000;
const app = express();
// const DB =
//     "mongodb+srv://akr2803:123@ecommerceapplication.ibqdbpv.mongodb.net/?retryWrites=true&w=majority";
const DB =
    "mongodb://akr2803:123@ac-ieqge19-shard-00-00.ibqdbpv.mongodb.net:27017,ac-ieqge19-shard-00-01.ibqdbpv.mongodb.net:27017,ac-ieqge19-shard-00-02.ibqdbpv.mongodb.net:27017/?ssl=true&replicaSet=atlas-d74wfg-shard-0&authSource=admin&retryWrites=true&w=majority";

// middleware
// CLIENT -> middleware -> SERVER -> CLIENT

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// Connecting DB
mongoose
    .connect(DB)
    .then(() => {
        console.log("DB Connected Successfully");
    })
    .catch((e) => console.log(e));

//CREATING AN API
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Listening at PORT ${PORT}`);
});

// GET, PUT, POST, DELETE, UPDATE -> CRUD
