mongoose = require('mongoose');

var Schema = mongoose.Schema;

var comusSchema = Schema({
    _id: mongoose.Schema.Types.ObjectId,
    name: { type: String },
    hobby: { type: String },
    users: { type: Array },
    descripcion: { type: String },
    foto: { type: String }
});

module.exports = mongoose.model('Comus', comusSchema);