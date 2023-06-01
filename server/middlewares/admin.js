const jwt = require("jsonwebtoken");
const User = require("../models/user");

const admin = async (req, res, next) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) {
            return res
                .status(401)
                .json({ msg: "No auth token, access denied" });
        }
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) {
            return res.status(401).json({
                msg: "Token verification failed, authorization denied.",
            });
        }

        const user = await User.findById(verified.id);

        if (user.type == "user" || user.type == "seller") {
            return res.status(401).json({
                msg: "Unauthorized access, you might not be an admin",
            });
        }

        req.user = verified.id;
        req.token = token;
        next();
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
};

module.exports = admin;
