<?php require $_SERVER['DOCUMENT_ROOT'] . '/student074/pruebas/header.php'; ?>

<main>

<?php    
    //connect to db
    $conn = mysqli_connect('localhost', 'root', '', 'student074_hotel_management_system');

    //check connection

    if(!$conn){
        echo 'erorr de conexión: ' . mysqli_connect_errno();
    }

    //mostrar resultado si se ha enviado el valor submit del formulario.
    if(isset($_POST['submit'])){

        $room_id = $_POST['room_id'];

        //querry for select specific room.
        $sql = 'SELECT * FROM rooms WHERE room_id ='.$room_id;

        // hacer consulta y obtener el resultado
        $result = mysqli_query($conn, $sql);

        // formatear resultado en una array asociativa
        $room = mysqli_fetch_all($result, MYSQLI_ASSOC);
    }
?>
<!-- formulario para cambiar valores -->
    <h3>Actualizar datos de una habitación</h3>

    <form action="/student074/pruebas/db/db_room_update.php" method="POST">
        <label for="room_id">Room id:</label>
        <input type="number" name="room_id" value="<?php echo $room[0]['room_id'] ?>" readonly>
        <label for="room_number" class="left">Room number:</label>
        <input type="number" name="room_number" value="<?php echo $room[0]['room_number'] ?>">
        <label for="floor_number" name="floor_number">Floor number:</label>
        <input type="number" name="floor_number" value="<?php echo $room[0]['floor_number'] ?>">
        <label for="room_capacity" name="room_capacity">Room capacity:</label>
        <input type="number" name="room_capacity" value="<?php echo $room[0]['room_capacity'] ?>">
        <label for="price_per_night" name="price_per_night">Price per night</label>
        <input type="number" name="price_per_night" value="<?php echo $room[0]['price_per_night'] ?>">
        <!-- investigar para mejor el boolean en html con php -->
        <label for="room_available">Room available:</label>
        <input type="number" min="0" max="1" name="room_available" value="<?php echo $room[0]['room_available'] ?>">

        <input type="submit" name="submit_update" value="Update" class="btn blue lighten-1"> 
    </form>

    <?php
        //actualizar resultado si se ha enviado el valor submit_update del formulario.
        if(isset($_POST['submit_update'])){
            // consulta sql
            $sql_update = 'UPDATE rooms SET
                            room_number ='.$_POST["room_number"].', floor_number ='.$_POST["floor_number"].', room_capacity ='.$_POST["room_capacity"].', price_per_night ='.$_POST["price_per_night"].', room_available ='.$_POST["room_available"].' 
                            WHERE room_id ='.$_POST["room_id"];

            // hacer consulta y obtener el resultado
            $update = mysqli_query($conn, $sql_update);

            //mejorar el mensaje feedback
            if($update){
                echo '<h3> Se han actualizado los datos correctamente </h3>';
            }else{
                echo '<h3> No se han podido actualizar los datos.</h3>';
            }
        }
    ?>
</main>

<?php require $_SERVER['DOCUMENT_ROOT'] . '/student074/pruebas/footer.php'; ?>