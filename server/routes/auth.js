const express = require("express");
const jwt = require("jsonwebtoken");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const auth = require("../middlewares/auth");

//SignUp route

// when admin will come it'll be authRouter.post('/admin/signup')
authRouter.post("/api/signup", async (req, res) => {
    // GET the data from the client
    //getting the data in the form of object from req.body
    /*
    {
        "name": name,
        "email" : email,
        "password" : password
    }
    
    In JavaScript we can directly access these values 
    by using keys like below
    (make sure keys don't have typing errors) 
    */

    try {
        //destructuring the object
        const { name, email, password } = req.body;

        //findOne is a promise
        const existingUser = await User.findOne({ email });

        if (existingUser) {
            return res
                .status(400)
                .json({ msg: "User with same email already exists" });
        }

        //when salt is added to the outcome of hash and it becomes unpredictable
        const hashedPassWord = await bcryptjs.hash(password, 8);

        //hashing the password before storing in the database
        let user = new User({
            name,
            email,
            password: hashedPassWord,
        });

        user = await user.save();
        // same thing res.json({user : user});
        res.json({ user });
        // POST the data in database
        // return the data to user
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//SignIn route

authRouter.post("/api/signin", async (req, res) => {
    try {
        //object destructuring
        const { email, password } = req.body;

        //finding the user in the database
        const user = await User.findOne({ email });

        //is email is not associated with a user
        //i.e, user may not have signed up
        if (!user) {
            return res.status(400).json({
                msg: "User with this email does not exist, please sign up first",
            });
        }
        //checking password while signing in
        const isMatch = await bcryptjs.compare(password, user.password);

        //incorrect password
        if (!isMatch) {
            return res.status(400).json({
                msg: "Incorrect Password",
            });
        }

        const token = jwt.sign({ id: user._id }, "passwordKey");

        res.json({ token, ...user._doc });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// Token verification
authRouter.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header("x-auth-token");

        //if there is no token or token is null
        if (!token) return res.json(false);

        //if token is not null, verify it
        const verified = jwt.verify(token, "passwordKey");

        //if token does not match, i.e. not verified
        if (!verified) return res.json(false);

        //if token is verified, check if the user
        //corresponding to that token exists
        const user = await User.findById(verified.id);

        //if user does not exist
        if (!user) return res.json(false);

        //token is not null, is verified, and user also exist
        res.json(true);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//Get user data
authRouter.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
