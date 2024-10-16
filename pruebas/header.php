<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel dani</title>
    <link rel="shortcut icon" href="/student074/dwes/img/logo_ico.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="/student074/dwes/css/style.css">
</head>
<body class="grey-text text-darken-3">
    <header>
        <nav  class="navbar-fixed">
            <div class="nav-wrapper grey lighten-5">
                <a href="#" class="brand-logo"><img src="/student074/dwes/img/logo.png" alt="imagen del logo" width="155px"></a>
                <a href="#" data-target="mobile-demo" class="sidenav-trigger grey-text"><i class="material-icons">menu</i></a>
                <ul class="right hide-on-med-and-down">
                    <li class="li-nav">  
                        <!-- Dropdown Trigger -->
                        <a class='dropdown-trigger grey-text text-darken-3' href='#' data-target='dropdown1'>Rooms</a>

                        <!-- Dropdown Structure -->
                        <ul id='dropdown1' class='dropdown-content'>
                            <li>
                                <a href="/student074/pruebas/forms/form_room_select.php" class="grey-text text-darken-3"><i class="material-icons left grey-text text-darken-3">hotel</i>Select</a>
                            </li>
                            <li class="divider" tabindex="-1"></li>
                            <li>
                            <a href="/student074/pruebas/forms/form_room_insert.php" class="grey-text text-darken-3"><i class="material-icons left grey-text text-darken-3">add</i>Insert</a>
                            </li>
                            <li class="divider" tabindex="-1"></li>
                            <li>
                            <a href="/student074/pruebas/forms/form_room_update.php" class="grey-text text-darken-3"><i class="material-icons left grey-text text-darken-3">edit</i>Update</a>
                            </li>
                            <li class="divider" tabindex="-1"></li>
                            <li>
                            <a href="/student074/pruebas/forms/form_room_delete.php" class="grey-text text-darken-3"><i class="material-icons left grey-text text-darken-3">delete</i>Delete</a>
                            </li>
                        </ul>
                    </li>

                    <li class="li-nav">
                        <!-- Dropdown Trigger -->
                        <a class='dropdown-trigger grey-text text-darken-3' href='#' data-target='dropdown1'>Customers</a>

                        <!-- Dropdown Structure -->
                        <ul id='dropdown1' class='dropdown-content'>
                            <li>
                                <a href="#!" class="grey-text text-darken-3"><i class="material-icons left grey-text text-darken-3">hotel</i>Select</a>
                            </li>
                            <li class="divider" tabindex="-1"></li>
                            <li>
                            <a href="#!" class="grey-text text-darken-3"><i class="material-icons left grey-text text-darken-3">add</i>Insert</a>
                            </li>
                            <li class="divider" tabindex="-1"></li>
                            <li>
                            <a href="#!" class="grey-text text-darken-3"><i class="material-icons left grey-text text-darken-3">edit</i>Update</a>
                            </li>
                            <li class="divider" tabindex="-1"></li>
                            <li>
                            <a href="#!" class="grey-text text-darken-3"><i class="material-icons left grey-text text-darken-3">delete</i>Delete</a>
                            </li>
                        </ul>
                    </li>

                    <li class="li-nav">
                        <!-- Dropdown Trigger -->
                        <a class='dropdown-trigger grey-text text-darken-3' href='#' data-target='dropdown1'>Reservations</a>

                        <!-- Dropdown Structure -->
                        <ul id='dropdown1' class='dropdown-content'>
                            <li>
                                <a href="#!" class="grey-text text-darken-3"><i class="material-icons left grey-text text-darken-3">hotel</i>Select</a>
                            </li>
                            <li class="divider" tabindex="-1"></li>
                            <li>
                            <a href="#!" class="grey-text text-darken-3"><i class="material-icons left grey-text text-darken-3">add</i>Insert</a>
                            </li>
                            <li class="divider" tabindex="-1"></li>
                            <li>
                            <a href="#!" class="grey-text text-darken-3"><i class="material-icons left grey-text text-darken-3">edit</i>Update</a>
                            </li>
                            <li class="divider" tabindex="-1"></li>
                            <li>
                            <a href="#!" class="grey-text text-darken-3"><i class="material-icons left grey-text text-darken-3">delete</i>Delete</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </nav>      
        <ul class="sidenav" id="mobile-demo">

            <ul class="collapsible">
                <li>
                    <div class="collapsible-header"><i class="material-icons"></i>Rooms</div>
                    <div class="collapsible-body">
                        <div>
                            <a href="/student074/pruebas/forms/form_room_select.php" class="grey-text text-darken-3 col s1">Select</a>
                        </div>
                        <div>
                            <a href="/student074/pruebas/forms/form_room_insert.php" class="grey-text text-darken-3">Insert</a>
                        </div>
                        <div>
                            <a href="/student074/pruebas/forms/form_room_update.php" class="grey-text text-darken-3">Update</a>
                        </div>
                        <div>
                            <a href="/student074/pruebas/forms/form_room_delete.php" class="grey-text text-darken-3">Delete</a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="collapsible-header"><i class="material-icons"></i>Customers</div>
                    <div class="collapsible-body">
                        <div>
                            <a href="#!" class="grey-text text-darken-3 col s1">Select</a>
                        </div>
                        <div>
                            <a href="#!" class="grey-text text-darken-3">Insert</a>
                        </div>
                        <div>
                            <a href="#!" class="grey-text text-darken-3">Update</a>
                        </div>
                        <div>
                            <a href="#!" class="grey-text text-darken-3">Delete</a>
                        </div>
                    </div>
                </li>
                <li>

                <li>
                    <div class="collapsible-header"><i class="material-icons"></i>Reservations</div>
                    <div class="collapsible-body">
                        <div>
                            <a href="#!" class="grey-text text-darken-3 col s1">Select</a>
                        </div>
                        <div>
                            <a href="#!" class="grey-text text-darken-3">Insert</a>
                        </div>
                        <div>
                            <a href="#!" class="grey-text text-darken-3">Update</a>
                        </div>
                        <div>
                            <a href="#!" class="grey-text text-darken-3">Delete</a>
                        </div>
                    </div>
                </li>      
            </ul> 
        </ul>
    </header>