'				Universidad Nacional de San Martín - UNSAM
'				Instituto de Altos Estudios Sociales - IDAES
'				Maestría en Desarrollo Económico  - MDE
'				Escuela de Invierno para Estudiantes de Economía
'				"Tópicos Avanzados de Economía Heterodoxa"

'				Taller de Modelización
'				Julio de 2016
'				Docentes: Guido Ianni y Nicolás Zeolla

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
'			Creación del ESPACIO DE TRABAJO
'			=============================

'				en la siguiente línea usted debe especificar el directorio donde grabará el archivo 
'				o grabarlo manualmente utilizando la opción "Save As" y haciendo click donde dice "Update default directory" (en cuyo caso comente la línea con un apóstrofe)

'cd "C:\Users\MiUsuario\Desktop"
'
'				Creamos el workfile, que llamamos "Clase1.wf1" 
'				(wf1 es la extensión estándar de los archivos de Eviews). 
'				Creamos también una página que se llame "MKS"
'				Luego ponemos las opciones
'						- "a" es de anuales (annual) pero pueden hacerse 
'						-"q" trimestrales (quarterly)
'						- "u" corte transversal (undated)
'						- etc
'				y agregamos que queremos que sea desde el año 2000 al 2050
'				Si el workfile existe, el comando wfcreate lo abre automáticamente, 
'				pero si además de existir se encuentra abierto, se abre una nueva copia. 
'
'
'
wfcreate(wf=Clase1,page=MKS) a 2000 2050
'				______________
'				Creación SERIES
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
recaud.displayname Recaudación

series ahorro=y-cons
ahorro.displayname Ahorro

'			__________________
' 			Creación Parámetros
'			---------------------------------
' 				Creamos los parámetros como si fueran series para tener más control sobre cuándo se pertuba al sistema cambiando el valor del parámetro en el momento exacto en que nosotros queremos.

series PMC
pmc.displayname Propensión a consumir

series CON_AUT
con_aut.displayname Consumo Autonomo

series T_AUT
T_AUT.displayname recaudacion autonoma

series T_Y
T_Y.displayname impuestos directos

'			________________________
'			Calibración de EXÓGENAS
'			------------------------------------------
series Inv=10
inv.displayname Inversión

series Gasto=10
gasto.displayname Gasto Publico
'			________________________
'			Calibración de PARÁMETROS
'			------------------------------------------
series CON_AUT=1

series PMC=0.8

series T_AUT=0

series T_Y=0.2
'			________________________________
'			Determinación de VALORES INICIALES
'			---------------------------------------------------------
'				para determinar los valores iniciales primero seteamos la "muestra" 
'				para eso usaremos la primera observación.
 
smpl @first @first
series yd=46.6666666666667

'				Finalmente, volvemos a setear el tamaño de la "muestra" a todo el rango donde vamos a trabajar con el modelo.

smpl @first+1 @last
'			================================
'						Creación del MODELO
'			================================
'				Ahora creamos el objeto modelos y lo llamamos modHD
'				Como se utiliza con frecuencia, le agregamos un guión bajo al principio para que aparezca primero en la vista gráfica del workfile 
'				Esto es así porque muchas veces los modelos son muy grandes y demandan una enorme cantidad de series (vamos a ver más adelante que la cantidad de series se multiplica unas cuantas veces)
'				Para garantizarnos que estamos emepezando con un modelo "en blanco", primero borramos el modelo.
'				La opción "noerr" permite al Eviews fallar en el intento de borrar el modelo sin dar como salida un "error" (es decir que si intenta borrar un objeto que no existe, siga ejecutando la rutina igual).
model _MKS
'				Este último comando crea el modelo. Si ejecuta el programa hasta acá, debería ver en el Workfile que apareció un objeto, llamado _modMR, y precedido por una "M" en color azul. 


'				tenemos un modelo "vacío", si queremos trabajar con él, debemos incorporar las ecuaciones
'			_______________________
'			Incorporación de Ecuaciones
'			----------------------------------------
'				Una vez creado el modelo, agregamos las ecuaciones
_MKS.append y=cons+inv+gasto

_MKS.append cons=CON_AUT+PMC*yd(-1)

_MKS.append yd=y-recaud

_MKS.append recaud=T_AUT+T_Y*y

_MKS.append ahorro=y-cons

'RESOLUCIÓN DEL MODELO 
'resolución del modelo
_MKS.solve
