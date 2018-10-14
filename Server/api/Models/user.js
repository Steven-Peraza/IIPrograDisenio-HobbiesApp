mongoose = require('mongoose')

const Schema = mongoose.Schema;

const userModel = Schema({
    name: { type: String   },
    hobby: { type: String }
})

module.exports = mongoose.model('users', userModel)