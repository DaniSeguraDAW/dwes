<?php require $_SERVER['DOCUMENT_ROOT'] . '/student074/pruebas/header.php'; ?>

<main>
<?php

//connect to db
$conn = mysqli_connect('localhost', 'root', '', 'student074_hotel_management_system');

//check connection

if(!$conn){
    echo 'erorr de conexión: ' . mysqli_connect_errno();
}

//querry for show all rooms
$sql = 'SELECT room_id, room_number, floor_number, room_capacity, price_per_night, room_available FROM rooms';

// hacer consulta y obtener el resultado
$result = mysqli_query($conn, $sql);

// formatear resultado en una array asociativa
$rooms = mysqli_fetch_all($result, MYSQLI_ASSOC);

?>
    <table class="striped centered"> <!-- higlight ??  responsive-table ?? -->
        <thead>
            <tr>
                <th>Room id</th>
                <th>Room number</th>
                <th>Floor number</th>
                <th>Room capacity</th>
                <th>Price per night</th>
                <th>Room available</th>
            </tr>
        </thead>

        <tbody>
            <?php foreach($rooms as $room): ?>
            <tr>
                <td> <?php echo $room['room_id']; ?> </td>
                <td> <?php echo $room['room_number']; ?> </td>
                <td> <?php echo $room['floor_number']; ?> </td>
                <td> <?php echo $room['room_capacity']; ?> </td>
                <td> <?php echo $room['price_per_night']; ?> </td>
                <td> <?php echo $room['room_available']; ?> </td>
            </tr>
            <?php endforeach ?>
        </tbody>
    </table>
</main>

<?php require $_SERVER['DOCUMENT_ROOT'] . '/student074/pruebas/footer.php'; ?>