mongoose = require('mongoose');

var Schema = mongoose.Schema;

var hobbitSchema = Schema({
    _id: mongoose.Schema.Types.ObjectId,
    hobbitName: { type: String },
});

module.exports = mongoose.model('Hobbit', hobbitSchema);