<?php
    // ARRAY NUMERICO
    $nombre1 = ['dani', 'arnau', 'peri'];
    //print_r($nombre1);


    $nombre2 = array('dani','arnau','peri');
    //print_r($nombre2);

    //Aray asociativo
    $alumno = ['nombre'=>'dani','apellido'=>'segura','edad'=>19];
    //print_r($alumno);

    //array asociativa multidimencional --> db
    $alumnos = [
        ['nombre'=>'dani','apellido'=>'segura','eded'=>19],
        ['nombre'=>'peri','apellido'=>'mozos','eded'=>19]
    ];

    //print_r($alumnos)

    //array_pop
    array_pop($alumnos);
    //print_r($alumnos);

    //unir 2 arrays
    $nombres = array_merge($nombre1, $nombre2);
    print_r($nombres)
    
?>