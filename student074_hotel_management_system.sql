-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-10-2024 a las 20:14:10
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hotel_management_system`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_random_reservation` (IN `var_loop_value` INT)   BEGIN
	DECLARE var_date_in DATE;
    DECLARE var_date_out DATE;
    DECLARE var_customer_id INT;
    DECLARE var_room_id INT;
    DECLARE var_price_per_night DECIMAL(10,2);
    DECLARE count_for_loop INT DEFAULT 1;
    DECLARE count_reservation INT;
    
    WHILE count_for_loop <= var_loop_value DO
    
    	-- get a random var_date_in
        SET var_date_in = CURRENT_DATE + INTERVAL FLOOR(RAND() * 100) DAY;
        
        -- get a random var_date_out
        SET var_date_out = var_date_in + INTERVAL FLOOR(RAND() * 15) DAY;
        
        -- get a random customer
        SELECT customer_id INTO var_customer_id
        FROM customers
        ORDER BY RAND()
        LIMIT 1;
        
        
    	-- get random room for customer
    	SELECT room_id, price_per_night INTO var_room_id, var_price_per_night
    	FROM rooms
    	WHERE room_id NOT IN (SELECT room_id
                         	  FROM reservations
                         	  WHERE date_in < var_date_out
                              AND date_out > var_date_in)
         AND room_available = 1
         ORDER BY RAND()
         LIMIT 1;
         
         -- validate if reservation exist
         SELECT COUNT(*) INTO count_reservation
         FROM reservations
         WHERE room_id = var_room_id
         AND date_in = var_date_in
         AND date_out = var_date_out;
         
         IF count_reservation = 0 THEN
             INSERT INTO reservations (customer_id, room_id, date_in, date_out, price_per_night)
             VALUES
                (var_customer_id, var_room_id, var_date_in, var_date_out, var_price_per_night);

             -- show the inserted
             SELECT var_customer_id, var_room_id, var_date_in, var_date_out, var_price_per_night; 
         END IF;
         SET count_for_loop = count_for_loop + 1;
	END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `isnert_reservation` (IN `var_customer_id` INT, IN `var_date_in` DATE, IN `var_date_out` DATE, IN `min_room_capacity` INT)   BEGIN
	DECLARE var_room_id INT;
	DECLARE var_price_per_night DECIMAL(10,2);
    
    -- get random room for customer
    SELECT room_id, price_per_night INTO var_room_id, var_price_per_night
    FROM rooms
    WHERE room_id NOT IN (SELECT room_id
                         FROM reservations
                         WHERE date_in < var_date_out
                         AND date_out > var_date_in)
	AND room_available = 1
    AND room_capacity >= min_room_capacity
    ORDER BY RAND()
    LIMIT 1;
    
    -- insert into reservations
    INSERT INTO reservations (customer_id, room_id, date_in, date_out, price_per_night)
    VALUES 
    	(var_customer_id, var_room_id, var_date_in, var_date_out, var_price_per_night);
	
    -- show the information
    SELECT var_customer_id, var_room_id, var_date_in, var_date_out, var_price_per_night; 
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_days_reservation` (`date_in` DATE, `date_out` DATE) RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE total_days INT;
    SET total_days = DATEDIFF(date_out, date_in);
    RETURN total_days;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `getAvailableRom` (`var_date_in` DATE, `var_date_out` DATE) RETURNS INT(11) DETERMINISTIC BEGIN
	DECLARE available_room_id INT;

	SELECT room_id INTO available_room_id
    FROM rooms
    WHERE room_id NOT IN (SELECT room_id
                          FROM reservations
                          WHERE date_in < var_date_out
                          AND date_out > var_date_in)
    AND room_available = 1
    ORDER BY RAND()
    LIMIT 1;
    
    RETURN available_room_id;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `for_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `nif` varchar(100) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `customers`
--

INSERT INTO `customers` (`customer_id`, `for_name`, `last_name`, `nif`, `phone`, `email`) VALUES
(1, 'for_name', 'last_name', 'nif', 'phone', 'email'),
(2, 'Jerry', 'Lambert', '88637717M', '1-342-173-', 'cras.sed@yahoo.couk'),
(3, 'Brady', 'Hall', '86975305E', '1-242-535-', 'eget.ipsum@google.org'),
(4, 'Renee', 'Tate', '33159438P', '502-5182', 'odio.a.purus@google.couk'),
(5, 'Fuller', 'Battle', '65031245C', '974-2473', 'eros.nec@protonmail.net'),
(6, 'Risa', 'Mccullough', '31934603K', '648-4315', 'magnis.dis.parturient@google.edu'),
(7, 'Lila', 'Dominguez', '68272166B', '551-9574', 'dui.nec@outlook.couk'),
(8, 'Victor', 'Adams', '78622735S', '1-853-750-', 'et@protonmail.ca'),
(9, 'Daquan', 'Rivera', '35058766J', '1-278-503-', 'adipiscing.ligula@protonmail.edu'),
(10, 'Branden', 'Hughes', '89422476Y', '644-1665', 'consequat.lectus.sit@protonmail.ca'),
(11, 'Ciaran', 'Townsend', '18654721Q', '982-0114', 'elit.pharetra@aol.edu'),
(12, 'Ashely', 'Benson', '86466836J', '1-774-381-', 'risus.quis@aol.com'),
(13, 'Geoffrey', 'Goff', '86786810N', '1-967-117-', 'nisl.arcu.iaculis@google.edu'),
(14, 'Simone', 'Wiley', '77111866S', '735-5967', 'dictum.ultricies@protonmail.couk'),
(15, 'Caesar', 'Morse', '27526686P', '1-697-425-', 'semper.rutrum@hotmail.ca'),
(16, 'September', 'Hess', '73686339U', '752-1135', 'sit.amet@hotmail.couk'),
(17, 'Hilary', 'Hopkins', '74117881F', '1-520-552-', 'tristique@protonmail.org'),
(18, 'Samson', 'Guerrero', '38686713D', '783-7238', 'aliquet.libero@hotmail.org'),
(19, 'Vance', 'Macdonald', '18468409S', '849-3098', 'aliquam.auctor@aol.edu'),
(20, 'Mannix', 'Mcintyre', '86811826T', '322-3566', 'nunc@icloud.edu'),
(21, 'Lacy', 'Johns', '65861148D', '1-426-854-', 'urna.ut@protonmail.org'),
(22, 'Len', 'Cervantes', '52848313W', '1-585-695-', 'elit.pellentesque@icloud.org'),
(23, 'Quintessa', 'Cleveland', '52932855Q', '365-4165', 'sed.dui@google.edu'),
(24, 'Darryl', 'Molina', '56512921N', '488-7816', 'accumsan.convallis@outlook.org'),
(25, 'Eric', 'Lamb', '85756160V', '1-717-164-', 'donec.sollicitudin.adipiscing@protonmail.org'),
(26, 'Macey', 'Mcclure', '44159561D', '1-201-106-', 'nulla@outlook.ca'),
(27, 'Orli', 'Lester', '84778713D', '1-875-584-', 'cras.vulputate.velit@protonmail.ca'),
(28, 'Kareem', 'Dorsey', '50866326I', '1-812-379-', 'ante.maecenas.mi@yahoo.com'),
(29, 'Ian', 'Carver', '81039910D', '1-741-313-', 'amet.luctus@hotmail.com'),
(30, 'Brett', 'Goff', '35118806I', '426-3295', 'elementum.lorem@outlook.ca'),
(31, 'Sara', 'Mayer', '88534512X', '1-444-616-', 'augue.sed.molestie@aol.net'),
(32, 'Miriam', 'Sloan', '43617884Y', '1-750-365-', 'pellentesque.habitant@icloud.com'),
(33, 'Curran', 'Vaughn', '25349007T', '461-3167', 'eget@aol.couk'),
(34, 'Tarik', 'Floyd', '98664131N', '845-2343', 'sed.orci@aol.org'),
(35, 'Abraham', 'Jackson', '45555667N', '1-508-658-', 'elit.elit.fermentum@google.com'),
(36, 'Jakeem', 'Charles', '75735322G', '1-653-476-', 'mollis.dui.in@protonmail.edu'),
(37, 'Rinah', 'Dickerson', '63228536G', '380-1178', 'cras.vulputate@hotmail.edu'),
(38, 'Xena', 'Humphrey', '82232335F', '461-8883', 'et.pede.nunc@aol.net'),
(39, 'Dennis', 'Dejesus', '77377861S', '432-2533', 'suspendisse@yahoo.com'),
(40, 'Kitra', 'Watson', '84833200M', '677-2164', 'aenean.eget.metus@aol.net'),
(41, 'Ramona', 'Baldwin', '56576632J', '446-6452', 'ornare@hotmail.com'),
(42, 'Alexandra', 'Hall', '37212822G', '1-415-845-', 'mattis.semper@icloud.couk'),
(43, 'Lunea', 'Page', '53427954Q', '1-262-530-', 'urna.et.arcu@outlook.org'),
(44, 'Zephr', 'Mosley', '18558443A', '170-4585', 'sit@yahoo.edu'),
(45, 'Hillary', 'Moon', '61703029T', '1-611-222-', 'mattis.cras@google.edu'),
(46, 'Xavier', 'Morris', '63870471Z', '1-385-980-', 'purus.accumsan.interdum@google.couk'),
(47, 'Wyatt', 'Lewis', '55724215G', '1-763-413-', 'condimentum.donec.at@google.ca'),
(48, 'Todd', 'Reid', '87858686C', '1-774-337-', 'donec.vitae.erat@outlook.couk'),
(49, 'Calvin', 'Bennett', '28373861X', '1-608-331-', 'natoque.penatibus.et@hotmail.com'),
(50, 'Ignacia', 'Blanchard', '37427714G', '362-4568', 'semper.tellus@hotmail.net'),
(51, 'Sydnee', 'Buckner', '26275703D', '1-545-711-', 'neque.non.quam@google.net'),
(52, 'Carissa', 'Walton', '60594571I', '628-1469', 'mauris.vel@google.org'),
(53, 'Channing', 'Holt', '38852088X', '1-675-817-', 'est@aol.ca'),
(54, 'Amery', 'Stein', '95163818H', '718-7570', 'vulputate.ullamcorper@protonmail.couk'),
(55, 'Gretchen', 'Mosley', '19066525P', '1-557-853-', 'donec@outlook.com'),
(56, 'Phyllis', 'Parks', '06200413U', '427-1744', 'in@aol.org'),
(57, 'Uriel', 'Holden', '74955426P', '488-1239', 'euismod@outlook.ca'),
(58, 'Acton', 'Stafford', '51515688X', '875-6429', 'in.cursus@yahoo.couk'),
(59, 'Cameron', 'Meadows', '70958829X', '611-6272', 'sed.nec@hotmail.edu'),
(60, 'Nora', 'Washington', '12194026H', '799-8824', 'magnis.dis.parturient@outlook.com'),
(61, 'Herrod', 'Flores', '52971613G', '551-2362', 'pede.nec.ante@aol.net'),
(62, 'Keely', 'Mullen', '38513235O', '157-3155', 'tempus.non@yahoo.ca'),
(63, 'Yuli', 'Mckinney', '86872370N', '1-446-633-', 'sit.amet@aol.edu'),
(64, 'Amethyst', 'Walls', '26177821F', '1-865-438-', 'nibh.quisque.nonummy@yahoo.org'),
(65, 'Thane', 'Dillon', '42155602V', '982-4952', 'egestas.rhoncus@outlook.couk'),
(66, 'Vernon', 'York', '23583217F', '1-777-985-', 'donec@hotmail.net'),
(67, 'Ebony', 'Justice', '46622526P', '1-524-644-', 'nunc.sed.libero@yahoo.couk'),
(68, 'Jordan', 'Armstrong', '45465764X', '272-4560', 'et.libero.proin@aol.edu'),
(69, 'Grant', 'Erickson', '10660579C', '436-5836', 'elit.dictum@yahoo.ca'),
(70, 'Madaline', 'Valentine', '64819704D', '1-901-451-', 'natoque.penatibus@outlook.couk'),
(71, 'Beatrice', 'Mejia', '48156624C', '1-660-860-', 'sodales@hotmail.net'),
(72, 'Summer', 'Velez', '81232333R', '453-4113', 'mauris.blandit@google.org'),
(73, 'Yeo', 'Baldwin', '82351038Y', '437-1371', 'fusce.mi.lorem@outlook.couk'),
(74, 'Colton', 'Goodman', '36560431F', '1-703-325-', 'nulla.cras@aol.org'),
(75, 'Brittany', 'Merrill', '43611925S', '512-4438', 'id.blandit@outlook.couk'),
(76, 'Claudia', 'Collier', '25214137X', '1-808-837-', 'nec.quam@google.org'),
(77, 'Mohammad', 'Mcmahon', '96285648X', '1-518-416-', 'a.arcu.sed@yahoo.ca'),
(78, 'Clarke', 'Rodriquez', '02282455N', '1-337-857-', 'erat.eget@outlook.com'),
(79, 'Aurora', 'Mcbride', '18748141K', '448-8804', 'commodo.tincidunt@google.ca'),
(80, 'Edan', 'Blake', '51063462F', '1-438-126-', 'eu@aol.org'),
(81, 'Alexandra', 'Tanner', '18468664A', '1-753-851-', 'interdum.curabitur.dictum@protonmail.couk'),
(82, 'Constance', 'Kent', '26654843B', '695-1548', 'nulla.semper@protonmail.couk'),
(83, 'Fay', 'Fuentes', '80335713U', '953-7228', 'sed.pede.nec@yahoo.net'),
(84, 'Levi', 'Koch', '43956221B', '1-928-838-', 'morbi@hotmail.couk'),
(85, 'Dexter', 'Vang', '85383975M', '1-137-268-', 'consectetuer@outlook.ca'),
(86, 'Uma', 'Hicks', '51077958Q', '1-337-975-', 'arcu.vestibulum@icloud.couk'),
(87, 'Cara', 'Glover', '90825788U', '569-4238', 'integer.tincidunt@outlook.ca'),
(88, 'Hall', 'Lane', '13705245W', '553-7362', 'dui@google.com'),
(89, 'Barrett', 'Pace', '86059558O', '1-661-577-', 'ut.mi.duis@outlook.ca'),
(90, 'Jolene', 'Mckinney', '43424474B', '1-136-634-', 'ipsum.cursus@yahoo.couk'),
(91, 'India', 'Little', '43533926U', '1-665-577-', 'non.lobortis.quis@outlook.net'),
(92, 'Kennedy', 'Donovan', '96337481F', '587-4384', 'risus.nulla@outlook.org'),
(93, 'Jessamine', 'House', '75275331C', '1-872-364-', 'magnis@google.org'),
(94, 'Justina', 'Mcmahon', '59436565Q', '1-345-222-', 'duis.sit@hotmail.net'),
(95, 'Yael', 'Campbell', '22870931M', '1-874-516-', 'semper.dui@yahoo.org'),
(96, 'Autumn', 'Kramer', '11143578D', '810-6369', 'pellentesque@protonmail.edu'),
(97, 'Zorita', 'Mann', '27655116L', '742-1211', 'magna.ut.tincidunt@google.couk'),
(98, 'Ivana', 'Miles', '61624803X', '1-524-326-', 'nisi.aenean@outlook.net'),
(99, 'Jackson', 'Howard', '85422647G', '646-2541', 'suscipit.est@google.couk'),
(100, 'Emerald', 'Wynn', '50307102W', '1-371-626-', 'sem@google.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customers_payments`
--

CREATE TABLE `customers_payments` (
  `customer_id` int(11) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `payment_method` enum('credit_debit_card','bank','paypal','cash_on_delivery') DEFAULT NULL,
  `card_expire_date` varchar(5) DEFAULT NULL,
  `card_number_` int(11) DEFAULT NULL,
  `card_cvv` int(11) DEFAULT NULL,
  `paypal_user` varchar(100) DEFAULT NULL,
  `paypal_password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservations`
--

CREATE TABLE `reservations` (
  `reservation_number` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `price_per_night` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservations`
--

INSERT INTO `reservations` (`reservation_number`, `customer_id`, `room_id`, `date_in`, `date_out`, `price_per_night`) VALUES
(2, 2, 3, '2024-07-13', '2024-07-18', 140.75),
(3, 19, 1, '2024-07-21', '2024-08-02', 120.00),
(4, 87, 1, '2024-08-21', '2024-09-02', 120.00),
(5, 35, 1, '2024-06-22', '2024-06-26', 120.00),
(6, 48, 1, '2024-07-07', '2024-07-07', 120.00),
(7, 40, 96, '2024-08-14', '2024-08-28', 125.00),
(8, 30, 58, '2024-09-22', '2024-09-26', 145.50),
(9, 95, 42, '2024-07-28', '2024-08-11', 130.50),
(10, 22, 3, '2024-08-27', '2024-08-30', 140.75),
(11, 16, 100, '2024-07-16', '2024-07-25', 160.00),
(12, 50, 94, '2024-07-13', '2024-07-24', 110.00),
(13, 84, 63, '2024-08-21', '2024-08-24', 140.75),
(14, 85, 35, '2024-08-31', '2024-09-06', 130.50),
(15, 34, 99, '2024-07-02', '2024-07-05', 150.00),
(16, 71, 33, '2024-06-17', '2024-06-28', 140.75),
(17, 87, 100, '2024-06-30', '2024-07-12', 160.00),
(18, 33, 66, '2024-07-14', '2024-07-19', 125.00),
(19, 1, 92, '2024-07-02', '2024-07-12', 130.50),
(20, 83, 52, '2024-07-26', '2024-07-31', 130.50),
(21, 15, 99, '2024-09-09', '2024-09-16', 150.00),
(22, 52, 46, '2024-07-15', '2024-07-15', 125.00),
(23, 45, 39, '2024-08-10', '2024-08-16', 130.50),
(24, 43, 62, '2024-09-08', '2024-09-19', 130.50),
(25, 96, 56, '2024-09-08', '2024-09-08', 125.00),
(26, 22, 86, '2024-08-31', '2024-09-03', 125.00),
(27, 2, 26, '2024-09-17', '2024-09-26', 125.00),
(28, 65, 36, '2024-09-09', '2024-09-22', 125.00),
(29, 10, 12, '2024-10-20', '2024-10-24', 130.50),
(30, 10, 96, '2024-10-20', '0000-00-00', 125.00),
(31, 36, 70, '2024-06-23', '2024-06-27', 160.00),
(32, 43, 32, '2024-08-08', '2024-08-11', 130.50),
(33, 24, 72, '2024-07-22', '2024-07-23', 130.50),
(34, 23, 8, '2024-08-30', '2024-09-01', 145.50),
(35, 3, 6, '2024-08-20', '2024-08-28', 125.00),
(36, 70, 54, '2024-07-06', '2024-07-18', 110.00),
(37, 3, 29, '2024-07-06', '2024-07-19', 150.00),
(38, 46, 16, '2024-07-07', '2024-07-10', 125.00),
(39, 30, 49, '2024-07-03', '2024-07-11', 150.00),
(40, 95, 4, '2024-09-17', '2024-09-28', 110.00),
(41, 63, 21, '2024-09-06', '2024-09-09', 120.00),
(42, 75, 4, '2024-08-27', '2024-09-06', 110.00),
(43, 62, 14, '2024-08-20', '2024-08-30', 110.00),
(44, 52, 26, '2024-08-08', '2024-08-21', 125.00);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `reservations_view`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `reservations_view` (
`reservation_number` int(11)
,`customer_id` int(11)
,`room_id` int(11)
,`date_in` date
,`date_out` date
,`price_per_night` decimal(10,2)
,`subtotal_price` decimal(20,2)
,`customer_fullname` varchar(101)
,`nif` varchar(100)
,`phone` varchar(10)
,`email` varchar(100)
,`room_number` int(11)
,`floor_number` int(11)
,`room_capacity` int(11)
,`room_available` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rooms`
--

CREATE TABLE `rooms` (
  `room_id` int(11) NOT NULL,
  `room_number` int(11) DEFAULT NULL,
  `floor_number` int(11) DEFAULT NULL,
  `room_capacity` int(11) DEFAULT NULL,
  `price_per_night` decimal(10,2) DEFAULT NULL,
  `room_available` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rooms`
--

INSERT INTO `rooms` (`room_id`, `room_number`, `floor_number`, `room_capacity`, `price_per_night`, `room_available`) VALUES
(1, 1, 1, 2, 120.00, 1),
(2, 2, 1, 3, 130.50, 0),
(3, 3, 1, 4, 140.75, 1),
(4, 4, 1, 1, 110.00, 1),
(5, 5, 1, 2, 115.25, 0),
(6, 6, 1, 3, 125.00, 1),
(7, 7, 1, 1, 135.00, 1),
(8, 8, 1, 4, 145.50, 1),
(9, 9, 1, 2, 150.00, 1),
(10, 10, 1, 3, 160.00, 1),
(11, 11, 2, 1, 120.00, 0),
(12, 12, 2, 4, 130.50, 1),
(13, 13, 2, 2, 140.75, 1),
(14, 14, 2, 3, 110.00, 1),
(15, 15, 2, 1, 115.25, 1),
(16, 16, 2, 4, 125.00, 1),
(17, 17, 2, 2, 135.00, 0),
(18, 18, 2, 3, 145.50, 1),
(19, 19, 2, 1, 150.00, 1),
(20, 20, 2, 4, 160.00, 1),
(21, 21, 3, 2, 120.00, 1),
(22, 22, 3, 3, 130.50, 1),
(23, 23, 3, 4, 140.75, 1),
(24, 24, 3, 1, 110.00, 0),
(25, 25, 3, 2, 115.25, 1),
(26, 26, 3, 3, 125.00, 1),
(27, 27, 3, 1, 135.00, 1),
(28, 28, 3, 4, 145.50, 1),
(29, 29, 3, 2, 150.00, 1),
(30, 30, 3, 3, 160.00, 1),
(31, 31, 4, 1, 120.00, 0),
(32, 32, 4, 4, 130.50, 1),
(33, 33, 4, 2, 140.75, 1),
(34, 34, 4, 3, 110.00, 1),
(35, 35, 4, 1, 115.25, 1),
(36, 36, 4, 4, 125.00, 1),
(37, 37, 4, 2, 135.00, 0),
(38, 38, 4, 3, 145.50, 1),
(39, 39, 4, 1, 150.00, 1),
(40, 40, 4, 4, 160.00, 1),
(41, 41, 5, 2, 120.00, 1),
(42, 42, 5, 3, 130.50, 1),
(43, 43, 5, 4, 140.75, 1),
(44, 44, 5, 1, 110.00, 0),
(45, 45, 5, 2, 115.25, 1),
(46, 46, 5, 3, 125.00, 1),
(47, 47, 5, 1, 135.00, 1),
(48, 48, 5, 4, 145.50, 1),
(49, 49, 5, 2, 150.00, 1),
(50, 50, 5, 3, 160.00, 1),
(51, 51, 6, 1, 120.00, 0),
(52, 52, 6, 4, 130.50, 1),
(53, 53, 6, 2, 140.75, 1),
(54, 54, 6, 3, 110.00, 1),
(55, 55, 6, 1, 115.25, 1),
(56, 56, 6, 4, 125.00, 1),
(57, 57, 6, 2, 135.00, 0),
(58, 58, 6, 3, 145.50, 1),
(59, 59, 6, 1, 150.00, 1),
(60, 60, 6, 4, 160.00, 1),
(61, 61, 7, 2, 120.00, 1),
(62, 62, 7, 3, 130.50, 1),
(63, 63, 7, 4, 140.75, 1),
(64, 64, 7, 1, 110.00, 0),
(65, 65, 7, 2, 115.25, 1),
(66, 66, 7, 3, 125.00, 1),
(67, 67, 7, 1, 135.00, 1),
(68, 68, 7, 4, 145.50, 1),
(69, 69, 7, 2, 150.00, 1),
(70, 70, 7, 3, 160.00, 1),
(71, 71, 8, 1, 120.00, 0),
(72, 72, 8, 4, 130.50, 1),
(73, 73, 8, 2, 140.75, 1),
(74, 74, 8, 3, 110.00, 1),
(75, 75, 8, 1, 115.25, 1),
(76, 76, 8, 4, 125.00, 1),
(77, 77, 8, 2, 135.00, 0),
(78, 78, 8, 3, 145.50, 1),
(79, 79, 8, 1, 150.00, 1),
(80, 80, 8, 4, 160.00, 1),
(81, 81, 9, 2, 120.00, 1),
(82, 82, 9, 3, 130.50, 1),
(83, 83, 9, 4, 140.75, 1),
(84, 84, 9, 1, 110.00, 0),
(85, 85, 9, 2, 115.25, 1),
(86, 86, 9, 3, 125.00, 1),
(87, 87, 9, 1, 135.00, 1),
(88, 88, 9, 4, 145.50, 1),
(89, 89, 9, 2, 150.00, 1),
(90, 90, 9, 3, 160.00, 1),
(91, 91, 10, 1, 120.00, 0),
(92, 92, 10, 4, 130.50, 1),
(93, 93, 10, 2, 140.75, 1),
(94, 94, 10, 3, 110.00, 1),
(95, 95, 10, 1, 115.25, 1),
(96, 96, 10, 4, 125.00, 1),
(97, 97, 10, 2, 135.00, 0),
(98, 98, 10, 3, 145.50, 1),
(99, 99, 10, 1, 150.00, 1),
(100, 100, 10, 4, 160.00, 1);

--
-- Disparadores `rooms`
--
DELIMITER $$
CREATE TRIGGER `tr_update_room_reservation` AFTER UPDATE ON `rooms` FOR EACH ROW BEGIN
	DECLARE var_counter INT;
    DECLARE i INT DEFAULT 1;
    DECLARE var_reservation_number INT;
    DECLARE var_date_in DATE;
    DECLARE var_date_out DATE;

	IF OLD.room_available = 1 AND NEW.room_available = 0 THEN
    	SELECT COUNT(reservation_number) INTO var_counter
        FROM reservations
        WHERE room_id = NEW.room_id 
        AND (CURRENT_DATE() <= date_in OR CURRENT_DATE() <= date_out);
        
        WHILE i <= var_counter DO
        	SELECT reservation_number, date_in, date_out INTO var_reservation_number, var_date_in, var_date_out
            FROM reservations
            WHERE room_id = NEW.room_id
            AND (CURRENT_DATE <= date_in OR CURRENT_DATE <= date_out)
            ORDER BY reservation_number
            LIMIT 1;
            
            UPDATE reservations SET room_id = getAvailableRom(var_date_in, var_date_out)
            WHERE reservation_number = var_reservation_number;
            SET i = i + 1;
        END WHILE;
        
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura para la vista `reservations_view`
--
DROP TABLE IF EXISTS `reservations_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `reservations_view`  AS SELECT `r`.`reservation_number` AS `reservation_number`, `r`.`customer_id` AS `customer_id`, `r`.`room_id` AS `room_id`, `r`.`date_in` AS `date_in`, `r`.`date_out` AS `date_out`, `r`.`price_per_night` AS `price_per_night`, `calculate_days_reservation`(`r`.`date_in`,`r`.`date_out`) * `r`.`price_per_night` AS `subtotal_price`, concat(`c`.`for_name`,' ',`c`.`last_name`) AS `customer_fullname`, `c`.`nif` AS `nif`, `c`.`phone` AS `phone`, `c`.`email` AS `email`, `ro`.`room_number` AS `room_number`, `ro`.`floor_number` AS `floor_number`, `ro`.`room_capacity` AS `room_capacity`, `ro`.`room_available` AS `room_available` FROM ((`reservations` `r` join `customers` `c` on(`r`.`customer_id` = `c`.`customer_id`)) join `rooms` `ro` on(`r`.`room_id` = `ro`.`room_id`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indices de la tabla `customers_payments`
--
ALTER TABLE `customers_payments`
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `payment_id` (`payment_id`);

--
-- Indices de la tabla `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indices de la tabla `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`reservation_number`),
  ADD KEY `fk_customer` (`customer_id`),
  ADD KEY `fk_room` (`room_id`);

--
-- Indices de la tabla `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT de la tabla `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reservations`
--
ALTER TABLE `reservations`
  MODIFY `reservation_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `customers_payments`
--
ALTER TABLE `customers_payments`
  ADD CONSTRAINT `customers_payments_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `customers_payments_ibfk_2` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`payment_id`);

--
-- Filtros para la tabla `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `fk_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `fk_room` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`);

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`root`@`localhost` EVENT `evnt_insert_random_reservation` ON SCHEDULE EVERY 20 MINUTE STARTS '2024-06-17 23:20:32' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
	DECLARE var_loop_value INT DEFAULT 3;
    SET var_loop_value = FLOOR(RAND()*10+1);
    CALL insert_random_reservation(var_loop_value);
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
