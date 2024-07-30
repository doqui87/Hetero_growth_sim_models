'				Universidad Nacional de San Mart�n - UNSAM
'				Instituto de Altos Estudios Sociales - IDAES
'				Maestr�a en Desarrollo Econ�mico  - MDE
'				Escuela de Invierno para Estudiantes de Econom�a
'				"T�picos Avanzados de Econom�a Heterodoxa"

'				Taller de Modelizaci�n
'				Julio de 2016
'				Docentes: Guido Ianni y Nicol�s Zeolla

''				========================================
'                                                                Clase 1
'				----------------------------------------------------------------------
'				                      El Modelo Keynesiano Simple
'				========================================
'
'
'
'
'
' -***********Comienzo del Programa
'			=============================
'			Creaci�n del ESPACIO DE TRABAJO
'			=============================

'				en la siguiente l�nea usted debe especificar el directorio donde grabar� el archivo 
'				o grabarlo manualmente utilizando la opci�n "Save As" y haciendo click donde dice "Update default directory" (en cuyo caso comente la l�nea con un ap�strofe)

'cd "C:\Users\MiUsuario\Desktop"
'
'				Creamos el workfile, que llamamos "Clase1.wf1" 
'				(wf1 es la extensi�n est�ndar de los archivos de Eviews). 
'				Creamos tambi�n una p�gina que se llame "MKS"
'				Luego ponemos las opciones
'						- "a" es de anuales (annual) pero pueden hacerse 
'						-"q" trimestrales (quarterly)
'						- "u" corte transversal (undated)
'						- etc
'				y agregamos que queremos que sea desde el a�o 2000 al 2050
'				Si el workfile existe, el comando wfcreate lo abre autom�ticamente, 
'				pero si adem�s de existir se encuentra abierto, se abre una nueva copia. 
'
'
'
wfcreate(wf=Clase1,page=MKS) a 2000 2050
'				______________
'				Creaci�n SERIES
'				------------------------
'					el comando comienza con la palabra "series" 
'					y luego se define el nombre para mostrar en las salidas (displayname)
series DA
da.displayname Demanda Agregada

series y
y.displayname Producto Bruto Interno

series yd
yd.displayname Ingreso Disponible

series CONS
cons.displayname Consumo

series Recaud
recaud.displayname Recaudaci�n

series ahorro=y-cons
ahorro.displayname Ahorro

'			__________________
' 			Creaci�n Par�metros
'			---------------------------------
' 				Creamos los par�metros como si fueran series para tener m�s control sobre cu�ndo se pertuba al sistema cambiando el valor del par�metro en el momento exacto en que nosotros queremos.

series PMC
pmc.displayname Propensi�n a consumir

series CON_AUT
con_aut.displayname Consumo Autonomo

series T_AUT
T_AUT.displayname recaudacion autonoma

series T_Y
T_Y.displayname impuestos directos

'			________________________
'			Calibraci�n de EX�GENAS
'			------------------------------------------
series Inv=10
inv.displayname Inversi�n

series Gasto=10
gasto.displayname Gasto Publico
'			________________________
'			Calibraci�n de PAR�METROS
'			------------------------------------------
series CON_AUT=1

series PMC=0.8

series T_AUT=0

series T_Y=0.2
'			________________________________
'			Determinaci�n de VALORES INICIALES
'			---------------------------------------------------------
'				para determinar los valores iniciales primero seteamos la "muestra" 
'				para eso usaremos la primera observaci�n.
 
smpl @first @first
series yd=46.6666666666667

'				Finalmente, volvemos a setear el tama�o de la "muestra" a todo el rango donde vamos a trabajar con el modelo.

smpl @first+1 @last
'			================================
'						Creaci�n del MODELO
'			================================
'				Ahora creamos el objeto modelos y lo llamamos modHD
'				Como se utiliza con frecuencia, le agregamos un gui�n bajo al principio para que aparezca primero en la vista gr�fica del workfile 
'				Esto es as� porque muchas veces los modelos son muy grandes y demandan una enorme cantidad de series (vamos a ver m�s adelante que la cantidad de series se multiplica unas cuantas veces)
'				Para garantizarnos que estamos emepezando con un modelo "en blanco", primero borramos el modelo.
'				La opci�n "noerr" permite al Eviews fallar en el intento de borrar el modelo sin dar como salida un "error" (es decir que si intenta borrar un objeto que no existe, siga ejecutando la rutina igual).
model _MKS
'				Este �ltimo comando crea el modelo. Si ejecuta el programa hasta ac�, deber�a ver en el Workfile que apareci� un objeto, llamado _modMR, y precedido por una "M" en color azul. 


'				tenemos un modelo "vac�o", si queremos trabajar con �l, debemos incorporar las ecuaciones
'			_______________________
'			Incorporaci�n de Ecuaciones
'			----------------------------------------
'				Una vez creado el modelo, agregamos las ecuaciones
_MKS.append y=cons+inv+gasto

_MKS.append cons=CON_AUT+PMC*yd(-1)

_MKS.append yd=y-recaud

_MKS.append recaud=T_AUT+T_Y*y

_MKS.append ahorro=y-cons

'RESOLUCI�N DEL MODELO 
'resoluci�n del modelo
_MKS.solve
