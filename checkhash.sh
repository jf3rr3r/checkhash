#!/bin/bash

echo "##############################################"
echo "           Comprobador de HASH                "
echo "##############################################"

################################### Sudoers ############################################

if [ "$(id -un)" != "root" ];
then
echo "Necesitas ser sudo..."
echo "Saliendo..."
exit;
fi

check_md5(){
        clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " 				MD5                             "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	read -p "Escribe el HASH 'ORIGINAL' del fichero: " hashMD5;
	read -p "Escribe la ruta absoluta o relativa donde esta ubicado el fichero a comprobar: " dir_file;
	if [[ -e $dir_file ]]
	then
		hash_md5=$(sudo md5sum $dir_file | cut -d " " -f 1);
		if [[ ${hashMD5,,} = ${hash_md5,,} ]]
		then
			echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			echo " Este fichero no has sido alterado, eres un crack ;)     "
			echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		else
			echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			echo " Este fichero has sido alterado, no eres un buen forense   "
			echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			echo " Miralo tú mismo por si no te fias listillo : $hashMD5 / $hash_md5 ";
		fi

	else
		echo " ERROR!! Este fichero no existe o no está en esta ruta ";
	fi
}

check_sha1(){
        clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " 				SHA1                             "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	read -p "Escribe el HASH 'ORIGINAL' del fichero: " hashSHA1;
	read -p "Escribe la ruta absoluta o relativa donde esta ubicado el fichero a comprobar: " dir_file;
	if [[ -e $dir_file ]]
	then
		hash_sha1=$(sha1sum $dir_file | cut -d " " -f 1);
		if [[ ${hashSHA1,,} = ${hash_sha1,,} ]]
		then
			echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			echo " Este fichero no has sido alterado, eres un crack ;)     "
			echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		else
			echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			echo " Este fichero has sido alterado, no eres un buen forense   "
			echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			echo " Miralo tú mismo por si no te fias listillo : $hashSHA1 / $hash_sha1 ";
		fi

	else
		echo " ERROR!! Este fichero no existe o no está en esta ruta ";
	fi
}

check_sha256(){
        clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " 			       SHA256                            "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	read -p "Escribe el HASH 'ORIGINAL' del fichero: " hashSHA256;
	read -p "Escribe la ruta absoluta o relativa donde esta ubicado el fichero a comprobar: " dir_file;
	if [[ -e $dir_file ]]
	then
		hash_sha256=$(sudo sha256sum $dir_file | cut -d " " -f 1);
		if [[ "${hashSHA256,,}" = "${hash_sha256,,}" ]]
		then
			echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			echo " Este fichero no has sido alterado, eres un crack ;)     "
			echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		else
			echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			echo " Este fichero has sido alterado, no eres un buen forense   "
			echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			echo " Miralo tú mismo por si no te fias listillo : $hashSHA256 / $hash_sha256 ";
		fi

	else
		echo " ERROR!! Este fichero no existe o no está en esta ruta ";
	fi
}

menu(){
	clear
	echo "=============================================="
	echo "    	   Comprobador de HASH              "
	echo "=============================================="
	echo "1 - Comprabar HASH MD5"
	echo "2 - Comprabar HASH SHA1"
	echo "3 - Comprabar HASH SHA256"
	echo "4 - Salir"
	read -p "Ingrese su elección [ 1 - 4 ] " -n1  eleccion

	case $eleccion in
		1)check_md5;;
		2)check_sha1;;
		3)check_sha256;;
		4)echo -e "\nSaliendo...";
		exit;;

		*)echo "Opcion no valida";;
	esac
}

while true;
do
        echo -e "\nPulsa la tecla Enter";
        read foo;
        menu;
done

################################### Function CTRL+C#######################################

crtl+c(){
	echo -e "\nSaliendo...";
	kill $PPID;
	exit 1;
}

trap 'crtl+c' INT
