<?php require $_SERVER['DOCUMENT_ROOT'] . '/student074/pruebas/header.php'; ?>

<main>
    <h3>Actualizar datos de una habitación</h3>
    <h3>Seleccione Room ID:</h3>

    <form action="/student074/pruebas/db/db_room_update.php" method="POST">
        <label for="room_id" class="left">Room id:</label>
        <input type="number" name="room_id" required>
        <input type="submit" name="submit" value="submit" class="btn blue lighten-1"> 
    </form>
</main>

<?php require $_SERVER['DOCUMENT_ROOT'] . '/student074/pruebas/footer.php'; ?>