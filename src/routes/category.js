const express = require('express');
const router = express.Router();
const pool = require('../database.js');

router.get('/',async (req,res) => {
    let listCategory = await pool.query('SELECT * FROM categorys');
    res.json({
        status: 200,
        message: "Se ha listado correctamente",
        listCategory: listCategory
    })
});

router.get('/:id', async(req,res) => {
    const {id} = req.params;
    let category = await pool.query('SELECT * FROM categorys WHERE id = ?',[id]);

    res.json({
        status: 200,
        message: "Se ha obtenido correctamente",
        category: category
    });
});

router.post('/create', async (req,res) => {
    const {name} = req.body;//obtenemos los valores
    const category = {
        name
    };

    await pool.query('INSERT INTO categorys SET ?', [category]);
    res.json({
        status: 200,
        message: "Se ha registrado correctamente",
        category: category
    });
});

router.post('/update/:id', async (req,res) => {
    const {id} = req.params;
    const {name} = req.body;
    const category = {name};

    await pool.query('UPDATE categorys SET ? WHERE id = ?',[category, id]);
    res.json({
        status: 200,
        message: "Se ha actualizado correctamente",
        category: category
    });
});

router.post('/delete/:id', async (req,res) =>{
    const {id} = req.params;
    await pool.query('DELETE FROM categorys WHERE id = ?', [id]);
    
    res.json({
        status: 200,
        message: "Se ha eliminado correctamente"
    });
});

module.exports = router;