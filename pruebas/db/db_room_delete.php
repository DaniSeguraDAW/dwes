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
    <h4>Cuidado, estas a punto de eliminar la siguiente habitación:</h4>

    <?php if(!isset($_POST['submit_delete'])):?>
    <div class="container center">
        <div class="row">
            <p class="col s6"><b>Room ID:</b> <?php echo $room[0]['room_id']; ?> </p>
            <p class="col s6"><b>Room number:</b> <?php echo $room[0]['room_number']; ?> </p>
            <p class="col s6"><b>Floor number:</b> <?php echo $room[0]['floor_number']; ?> </p>
            <p class="col s6"><b>Room capacity:</b> <?php echo $room[0]['room_capacity']; ?> </p>
            <p class="col s6"><b>Price per night:</b> <?php echo $room[0]['price_per_night']; ?> </p>
            <p class="col s6"><b>Room available:</b> <?php echo $room[0]['room_available']; ?> </p>
        </div>  
    </div>

    <form action="/student074/pruebas/db/db_room_delete.php" method="POST">
        <!-- enviar room_id escondido para la consuta sql de delete. -->
        <input type="hidden" name="room_id" value=" <?php echo $room[0]['room_id']; ?> ">
        <input type="submit" name="submit_delete" value="Delete" class="btn blue lighten-1">
        <a href="/student074/pruebas/forms/form_room_delete.php" class="btn blue lighten-1">Cancel</a>
    </form>
    <?php endif ?>

    <?php
        //actualizar resultado si se ha enviado el valor submit_update del formulario.
        if(isset($_POST['submit_delete'])){
            // consulta sql
            $sql_delete = 'DELETE FROM rooms WHERE room_id ='.$_POST["room_id"];

            // hacer consulta y obtener el resultado
            $delete = mysqli_query($conn, $sql_delete);

            //mejorar el mensaje feedback
            if($delete){
                echo '<h4>Se ha eliminado correctamente la habitación</h4>';
            }else{
                echo '<h4>No se han podido eliminar la habitación.</h4>';
            }
        }
    ?>
</main>

<?php require $_SERVER['DOCUMENT_ROOT'] . '/student074/pruebas/footer.php'; ?>