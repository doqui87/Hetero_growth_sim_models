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
'                                                Clase 3 - Primera  Parte
'				----------------------------------------------------------------------
'                       Cierres Heterodoxos en Modelos de Crecimiento
'                    ----------------------------------------------------------------------
'                                Ecuaci�n de Cambridge y Neokaleckiano
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

'cd "D:\Dropbox\Facu\UNSAM\Varios\Escuela de Invierno 2015\Taller Modelizaci�n\PrgEviews"
'
'				Creamos el workfile, que llamamos "Clase3.wf1" 
'				(wf1 es la extensi�n est�ndar de los archivos de Eviews). 
'				Creamos tambi�n una p�gina que se llame "Cierres_Alternativos"
'				Luego ponemos las opciones
'						- "a" es de anuales (annual) pero pueden hacerse 
'						-"q" trimestrales (quarterly)
'						- "u" corte transversal (undated)
'						- etc
'				y agregamos que queremos que sea desde el a�o 2000 al 2050
'				Si el workfile existe, el comando wfcreate lo abre autom�ticamente, 
'				pero si adem�s de existir se encuentra abierto, se abre una nueva copia. 
'				Para evitar confundir con cu�l estamos trabajando y para evitar trabajo, primero cerramos cualquier copia que pudiera haber abierta

close Clase3.wf1
wfcreate(wf=Clase3,page=Cierres_Alternativos) a 2000 2050
delete *

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

series INV
inv.displayname Inversi�n

series PMC
pmc.displayname Propensi�n a Consumir

series U
u.displayname Utilizaci�n de la Capacidad

series GY
gy.displayname Crecimiento Producto

series GI
gi.displayname Crecimiento Inversi�n

series GK
gk.displayname Crecimiento Capital

series DISTR
distr.displayname Participaci�n Beneficios

'			__________________
' 			Creaci�n Par�metros
'			---------------------------------
' 				Creamos los par�metros como si fueran series para tener m�s control sobre cu�ndo se pertuba al sistema cambiando el valor del par�metro en el momento exacto en que nosotros queremos.

series V
v.displayname Relaci�n Capital/Producto

series GAMMA
gamma.displayname Sensibilidad de Inversi�n

series GESP
gesp.displayname Crecimiento Esperado Demanda

series CPI
cpi.displayname Propensi�n a Consumir Capitalistas

series CW
cw.displayname Propensi�n Consumir Asalariados


'			________________________
'			Calibraci�n de  PARAMETROS
'			------------------------------------------
'				Par�metros ambos cierres
CPI=0.6
CW=1
v=2
gesp=0.1
gamma=0.1

'				Par�metros Cambridge
u=1

'				Par�metros Cierre Kaleckiano
distr=0.5

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
PRODPOT=pbi
CAP=v*prodpot
inv=cap*gesp

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

delete(noerr) _ModCierres
model _modCierres

'				Este �ltimo comando crea el modelo. Si ejecuta el programa hasta ac�, deber�a ver en el Workfile que apareci� un objeto, llamado _modMR, y precedido por una "M" en color azul. 


'				tenemos un modelo "vac�o", si queremos trabajar con �l, debemos incorporar las ecuaciones
'			_______________________
'			Incorporaci�n de Ecuaciones
'			----------------------------------------
'				Una vez creado el modelo, agregamos las ecuaciones

'				Demanda Agregada
_modCierres.append DA=cons+inv
'				Consumo
_modCierres.append CONS=pmc*pbi
'				Ahorro
_modCierres.append AHORRO=pbi-cons
'				Din�mica Stock de Capital
_modCierres.append CAP=cap(-1)+inv(-1)
'				Producto Potencial
_modCierres.append PRODPOT=cap/v
'				Condici�n de Equilibrio
_modCierres.append PBI=da
'				Inversi�n
_modCierres.append INV=cap*(gesp+gamma*(u(-1)-1))
'				Tasas de Crecimiento
_modCierres.append Gy=(pbi-pbi(-1))/pbi(-1)
_modCierres.append Gi=(inv-inv(-1))/inv(-1)
_modCierres.append Gk=(cap-cap(-1))/cap(-1)

'			_______________________
'			Creaci�n de Escenarios
'			----------------------------------------

'					Escenario: Cierre basado en la Ecuaci�n de Cambridge"
_modCierres.scenario(n, a=Cam) "Ecuacion de Cambridge"
_modCierres.append PMC=1-gy*v/u
_modCierres.append DISTR=(pmc-cw)/(cpi-cw)
_modCierres.solve
'					Escenario: Cierre Neo-Kaleckiano
_modCierres.scenario(n, a=NK) "NeoKaleckiano"
_modCierres.drop pmc distr
_modCierres.append PMC=cw+(cpi-cw)*distr
_modCierres.append u=pbi/prodpot
_modCierres.solve


