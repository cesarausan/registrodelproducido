<?php
$cedula = $_POST['cedula'];
$nombre = $_POST['nombre'];
$apellido = $_POST['apellido'];
$direccion = $_POST['direccion'];
$celular = $_POST['celular'];
$correo = $_POST['correo'];
$usuario = $_POST['usuario'];
$contrasena = $_POST['contrasena'];
$tipousuario = $_POST['tipousuario'];

$host="localhost";
$port=3306;
$socket="";
$user="root";
$password="123456";
$dbname="transportadora";

$con = new mysqli($host, $user, $password, $dbname, $port, $socket);
	if(mysqli_connect_error()){
	 die ('Could not connect to the database server' . mysqli_connect_error());
	}
	else{
		$SELECT = "SELECT cedula_usu from usuario where cedula_usu = ? limit 1 ";
		$INSERT = "INSERT INTO usuario (cedula_usu,idtipo_usuario,nombre_usu,apellido_usu,email_usu,username,password,direccion_usu,celular_usu)
		VALUES(?,?,?,?,?,?,?,?,?)";
		$stmt = $con->prepare($SELECT);
		$stmt ->bind_param("i",$cedula);
		$stmt ->execute();
		$stmt ->bind_result($cedula);
		$stmt ->store_result();
		$rnum =$stmt->num_rows;
		if($rnum == 0){
			$stmt ->close();
			$stmt = $con->prepare($INSERT);
			$stmt ->bind_param("iisssssss",$cedula,$tipousuario,$nombre,$apellido,$correo,$usuario,$contrasena,$direccion,$celular);
			$stmt ->execute();
			echo "Registro Completado.";
		}
		else{
			echo "Ya existe el usuario. ";
		}
		$stmt->close();
		$con->close();
	}
		
?>