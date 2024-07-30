'				Universidad Nacional de San Mart�n - UNSAM
'				Instituto de Altos Estudios Sociales - IDAES
'				Maestr�a en Desarrollo Econ�mico  - MDE
'				Escuela de Invierno para Estudiantes de Econom�a
'				"T�picos Avanzados de Econom�a Heterodoxa"
'				Taller de Modelizaci�n
'				Julio de 2016
'				Coordinador: Guido Ianni
'				Docentes: Guido Ianni y Nicol�s Zeolla
'
'				========================================
'                                                 Clase 2  - Segunda Parte
'				----------------------------------------------------------------------
'						Una Adaptaci�n del Modelo Harrod-Domar
'                    ----------------------------------------------------------------------
'                                  Crecimiento en el Sendero Garantizado
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

'				en la siguiente l�nea usted debe (en cuyo caso comente la l�nea con un ap�strofe) especificar el directorio donde grabar� el archivo 
'				o grabarlo manualmente utilizando la opci�n "Save As" y haciendo click donde dice "Update default directory" 

'cd "F:\Dropbox\Facu\UNSAM\Varios\Escuela de Invierno 2016\PrgEviews"
'
'				Creamos el workfile, que llamamos "Clase2.wf1" 
'				(wf1 es la extensi�n est�ndar de los archivos de Eviews). 
'				Creamos tambi�n una p�gina que se llame "Harrod_Domar"
'				Luego ponemos las opciones
'						- "a" es de anuales (annual), pero pueden hacerse 
'						-"q" trimestrales (quarterly)
'						- "u" corte transversal (undated)
'						- etc
'				y agregamos que queremos que sea desde el a�o 2000 al 2050
'Para evitar confundir con cu�l estamos trabajando y para evitar trabajo, primero cerramos cualquier copia que pudiera haber abierta
close clase2.wf1
wfcreate(wf=Clase2,page=Harrod_Domar) a 2000 2050
delete *
'
'				______________
'				Creaci�n SERIES
'				------------------------
'					el comando comienza con la palabra "series" 
'					y luego se define el nombre para mostrar en las salidas (displayname)

series DA
da.displayname Demanda Agregada

series CONS
cons.displayname Consumo

series AHORRO
ahorro.displayname Ahorro

series CAP
cap.displayname Stock de Capital

series PRODPOT
prodpot.displayname Capacidad Insalada

series PBI
pbi.displayname Producto Interno

series U
u.displayname Utilizaci�n de la Capacidad

series INV
inv.displayname Inversi�n

series GESP
gesp.displayname Crecimiento Esperado



'			__________________
' 			Creaci�n Par�metros
'			---------------------------------
' 				Creamos los par�metros como si fueran series para tener m�s control sobre cu�ndo se pertuba al sistema cambiando el valor del par�metro en el momento exacto en que nosotros queremos.

series PMC
pmc.displayname Propensi�n a Consumir

series V
v.displayname Relaci�n Capital/Producto

series gamma
gamma.displayname Sensibilidad de la inversi�n

'			________________________
'			Calibraci�n de  PARAMETROS
'			------------------------------------------

PMC=0.8
V=2
gamma=0

'              _____________________________
'              Valores de las variables EXOGENAS
'             ----------------------------------------------------

'			________________________________
'			Determinaci�n de VALORES INICIALES
'			---------------------------------------------------------
'				para determinar los valores iniciales primero seteamos la "muestra" 
'				para eso usaremos la primera observaci�n.
 
smpl @first @first

'				Luego, asumimos que partimos de una situaci�n de equilibrio.
'				Elegimos el valor para el PBI

PBI=1

'				Y, el resto de las variables, las determinamos a partir de dicho valor inicial de forma tal de asegurar el equilibrio en el primer per�odo

INV=(1-pmc)*pbi
PRODPOT=PBI
CAP=v*ProdPot
U=pbi/prodpot


'				Finalmente, volvemos a setear el tama�o de la "muestra" a todo el rango donde vamos a trabajar con el modelo.

smpl @first+1 @last

'			================================
'						Creaci�n del MODELO
'			================================
'				Para garantizarnos que estamos emepezando con un modelo "en blanco", primero borramos el modelo.
'				La opci�n "noerr" permite al Eviews fallar en el intento de borrar el modelo sin dar como salida un "error" (es decir que si intenta borrar un objeto que no existe, siga ejecutando la rutina igual).

delete(noerr) _ModHD
'				Ahora creamos el objeto modelos y lo llamamos modHD
'				Como se utiliza con frecuencia, le agregamos un gui�n bajo al principio para que aparezca primero en la vista gr�fica del workfile 
'				Esto es as� porque muchas veces los modelos son muy grandes y demandan una enorme cantidad de series (vamos a ver m�s adelante que la cantidad de series se multiplica unas cuantas veces)

model _modHD

'				Este �ltimo comando crea el modelo. Si ejecuta el programa hasta ac�, deber�a ver en el Workfile que apareci� un objeto, llamado _modHD, y precedido por una "M" en color azul. 

'				tenemos un modelo "vac�o", si queremos trabajar con �l, debemos incorporar las ecuaciones
'			_______________________
'			Incorporaci�n de Ecuaciones
'			----------------------------------------
'				Una vez creado el modelo, agregamos las ecuaciones

'				Demanda Agregada
_modHD.append DA=cons+inv
'				Consumo
_modHD.append CONS=pmc*pbi
'				Ahorro Agregado
_modHD.append AHORRO=pbi-cons
'				Din�mica del stock de capital
_modHD.append CAP=inv(-1)+cap(-1)
'				Capacidad instalada
_modHD.append PRODPOT=cap/v
'				Utilizaci�n de la capacidad instalada
_modHD.append U=pbi/prodpot
'				Condici�n de Equilibrio
_modHD.append PBI=da
'				Inversi�n
_modHD.append INV=cap*(gesp+gamma*(u(-1)-1))
'				Tasa crecimiento=tasa garantizada
_modHD.append gesp=(1-pmc)/v

'              ________________________________
'              Resoluci�n del modelo
'             ---------------------------------------------------------
_modHD.solve


