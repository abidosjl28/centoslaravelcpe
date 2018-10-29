# INSTALACION COMPROBANTE DE PAGO ELECTRONICO con CentOS 7 Laravel

### INSTALACION CENTOS EN SERVIDOR VPS

 Actualizar el CentOS.

	# yum update -y
	
 Instalar el repositorio git

	# yum install git
 	
 
 Clonar el repositorio de la instalación de CPE
 
 	# https://github.com/croelanjr/centoslaravelcpe.git
 	
 Subir el proyecto de Comprobante de pago electronico y mover a la carpeta del repositorio de github.
 
 	# mv proyecto.rar /root/centoslaravelcpe/
 
 Abrir la carpeta
 
 	# cd /root/centoslaravelcpe/
 	
 Abrir los permisos del archivo del instalador
 
 	# chmod +x install.sh
 	
 Ejecutar el instalador del CPE
 
 	# ./install.sh

## NOTA
 
 No se olvide de migrar base de datos y reiniciar el servidor. Tenga presente que el nombre de la carpeta del proyecto debe coincidir la carpeta que aparece en el archivo install.sh 
	

 	
 	
 	
 