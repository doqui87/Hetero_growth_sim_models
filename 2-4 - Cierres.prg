'				Universidad Nacional de San Martín - UNSAM
'				Instituto de Altos Estudios Sociales - IDAES
'				Maestría en Desarrollo Económico  - MDE
'				Escuela de Invierno para Estudiantes de Economía
'				"Tópicos Avanzados de Economía Heterodoxa"
'				Taller de Modelización
'				Julio de 2016
'				Coordinador: Guido Ianni
'				Docentes: Guido Ianni y Nicolás Zeolla
'
'				========================================
'                                                Clase 3 - Primera  Parte
'				----------------------------------------------------------------------
'                       Cierres Heterodoxos en Modelos de Crecimiento
'                    ----------------------------------------------------------------------
'                                Ecuación de Cambridge y Neokaleckiano
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

'cd "D:\Dropbox\Facu\UNSAM\Varios\Escuela de Invierno 2015\Taller Modelización\PrgEviews"
'
'				Creamos el workfile, que llamamos "Clase3.wf1" 
'				(wf1 es la extensión estándar de los archivos de Eviews). 
'				Creamos también una página que se llame "Cierres_Alternativos"
'				Luego ponemos las opciones
'						- "a" es de anuales (annual) pero pueden hacerse 
'						-"q" trimestrales (quarterly)
'						- "u" corte transversal (undated)
'						- etc
'				y agregamos que queremos que sea desde el año 2000 al 2050
'				Si el workfile existe, el comando wfcreate lo abre automáticamente, 
'				pero si además de existir se encuentra abierto, se abre una nueva copia. 
'				Para evitar confundir con cuál estamos trabajando y para evitar trabajo, primero cerramos cualquier copia que pudiera haber abierta

close Clase3.wf1
wfcreate(wf=Clase3,page=Cierres_Alternativos) a 2000 2050
delete *

'				______________
'				Creación SERIES
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
inv.displayname Inversión

series PMC
pmc.displayname Propensión a Consumir

series U
u.displayname Utilización de la Capacidad

series GY
gy.displayname Crecimiento Producto

series GI
gi.displayname Crecimiento Inversión

series GK
gk.displayname Crecimiento Capital

series DISTR
distr.displayname Participación Beneficios

'			__________________
' 			Creación Parámetros
'			---------------------------------
' 				Creamos los parámetros como si fueran series para tener más control sobre cuándo se pertuba al sistema cambiando el valor del parámetro en el momento exacto en que nosotros queremos.

series V
v.displayname Relación Capital/Producto

series GAMMA
gamma.displayname Sensibilidad de Inversión

series GESP
gesp.displayname Crecimiento Esperado Demanda

series CPI
cpi.displayname Propensión a Consumir Capitalistas

series CW
cw.displayname Propensión Consumir Asalariados


'			________________________
'			Calibración de  PARAMETROS
'			------------------------------------------
'				Parámetros ambos cierres
CPI=0.6
CW=1
v=2
gesp=0.1
gamma=0.1

'				Parámetros Cambridge
u=1

'				Parámetros Cierre Kaleckiano
distr=0.5

'			________________________________
'			Determinación de VALORES INICIALES
'			---------------------------------------------------------
'				para determinar los valores iniciales primero seteamos la "muestra" 
'				para eso usaremos la primera observación.
 
smpl @first @first

'				Luego, asumimos que partimos de una situación de equilibrio.
'				Elegimos el valor para el PBI

PBI=1

'				Y, el resto de las variables, las determinamos a partir de dicho valor inicial de forma tal de asegurar el equilibrio en el primer período
PRODPOT=pbi
CAP=v*prodpot
inv=cap*gesp

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

delete(noerr) _ModCierres
model _modCierres

'				Este último comando crea el modelo. Si ejecuta el programa hasta acá, debería ver en el Workfile que apareció un objeto, llamado _modMR, y precedido por una "M" en color azul. 


'				tenemos un modelo "vacío", si queremos trabajar con él, debemos incorporar las ecuaciones
'			_______________________
'			Incorporación de Ecuaciones
'			----------------------------------------
'				Una vez creado el modelo, agregamos las ecuaciones

'				Demanda Agregada
_modCierres.append DA=cons+inv
'				Consumo
_modCierres.append CONS=pmc*pbi
'				Ahorro
_modCierres.append AHORRO=pbi-cons
'				Dinámica Stock de Capital
_modCierres.append CAP=cap(-1)+inv(-1)
'				Producto Potencial
_modCierres.append PRODPOT=cap/v
'				Condición de Equilibrio
_modCierres.append PBI=da
'				Inversión
_modCierres.append INV=cap*(gesp+gamma*(u(-1)-1))
'				Tasas de Crecimiento
_modCierres.append Gy=(pbi-pbi(-1))/pbi(-1)
_modCierres.append Gi=(inv-inv(-1))/inv(-1)
_modCierres.append Gk=(cap-cap(-1))/cap(-1)

'			_______________________
'			Creación de Escenarios
'			----------------------------------------

'					Escenario: Cierre basado en la Ecuación de Cambridge"
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


