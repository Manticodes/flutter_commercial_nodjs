const jwt = require('jsonwebtoken')
const auth = async (req, res, next) => {
    try {
        //i removed some un necessary codes from course
        const token = req.header('x-auth-token');

        const verified = jwt.verify(token, "passwordKey");
        req.userId = verified.id;
        req.token = token
        next();
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
}
module.exports = auth;