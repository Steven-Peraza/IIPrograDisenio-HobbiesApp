const Publication = require("../Models/publication")

exports.addNewPublication = (req, res) => {
    const newPublication = new Publication({
        _id: new mongoose.Types.ObjectId(),
        text: req.body["text"],
        tipoMultimedia: req.body["tipoMultimedia"],
        linkMultimedia: req.body["linkMultimedia"],
        fechaPublicacion: Date.now(),
        type: req.body["type"],
        reacciones: [],
        comentarios: [],
        hobby: req.body["hobby"],
        username: req.body["username"]
        
    });
    newPublication.save().then((result) => {
        console.log(result);
    }).catch((err) => {
        console.log(err);
    });
    res.status(201).send(newPublication);
}

exports.getPublicationsByHobby = (req,res)=>{

Publication.find({hobby:req.params.hobby})
.then(
    (doc)=>{
        if (doc) {
            console.log(doc._id);
            res.status(201).send(doc);
        } else {
            console.log("no data exist for this id");
            res.status(500).send("No hay publicaciones para este hobby");
        }  
    }
)


}