mongoose = require('mongoose');

var Schema = mongoose.Schema;

var userSchema = Schema({
    _id: mongoose.Schema.Types.ObjectId,
    name: { type: String },
    lastName: { type: String },
    nick: { type: String },
    ubicacion: { type: String },
    email: { type: String },
    pass: { type: String },
    hobbies: { type: Array },
    comunidades: { type: Array },
    bio: { type: String },
    foto: { type: String }
});

module.exports = mongoose.model('Users', userSchema);