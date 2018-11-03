mongoose = require('mongoose');

var Schema = mongoose.Schema;

var publicationSchema = Schema({
    _id: mongoose.Schema.Types.ObjectId,
    text: { type: String },
    tipoMultimedia: { type: String },
    linkMultimedia: {type:String},
    fechaPublicacion: { type: Date },
    type: { type: String },
    reacciones: { type: Array },
    comentarios: { type: Array },
    hobby: {type: String}
});

module.exports = mongoose.model('Publication', publicationSchema);