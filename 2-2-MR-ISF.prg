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
'                                              Clase 2  - Primera Parte
'				----------------------------------------------------------------------
'						            Modelo Keynesiano Simple
'                    ----------------------------------------------------------------------
'                              Inconsistencia Stock-Flujo de Largo Plazo
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

'				en la siguiente línea usted debe (en cuyo caso comente la línea con un apóstrofe) especificar el directorio donde grabará el archivo 
'				o grabarlo manualmente utilizando la opción "Save As" y haciendo click donde dice "Update default directory" 

'cd "F:\Dropbox\Facu\UNSAM\Varios\Escuela de Invierno 2016\PrgEviews"
'
'				Creamos el workfile, que llamamos "Clase2.wf1" 
'				(wf1 es la extensión estándar de los archivos de Eviews). 
'				Creamos también una página que se llame "Harrod_Domar"
'				Luego ponemos las opciones
'						- "a" es de anuales (annual), pero pueden hacerse 
'						-"q" trimestrales (quarterly)
'						- "u" corte transversal (undated)
'						- etc
'				y agregamos que queremos que sea desde el año 2000 al 2050
'Para evitar confundir con cuál estamos trabajando y para evitar trabajo, primero cerramos cualquier copia que pudiera haber abierta
close clase2.wf1
wfcreate(wf=Clase2,page=MKSenelLP) a 2000 2050
delete *
'
'				______________
'				Creación SERIES
'				------------------------
'					el comando comienza con la palabra "series" 
'					y luego se define el nombre para mostrar en las salidas (displayname)


'			_________________
' 			variables ENDÓGENAS
'			-----------------------------
'                  
series DA
da.displayname Demanda Agregada

series CONS
cons.displayname Consumo

series PBI
pbi.displayname Producto Interno

series AHORRO
ahorro.displayname Ahorro

series CAP
cap.displayname Stock de Capital

series PRODPOT
prodpot.displayname Capacidad Insalada

series U
u.displayname Utilización de la Capacidad
'			_________________
' 			variables EXÓGENAS
'			-----------------------------
'                        

series INV
inv.displayname Inversión



'			_________________
' 			Creación Parámetros
'			-----------------------------
' 				Creamos los parámetros como si fueran series para tener más control sobre cuándo se pertuba al sistema cambiando el valor del parámetro en el momento exacto en que nosotros queremos.

series PMC
pmc.displayname Propensión a Consumir

series V
v.displayname Relación Capital/Producto



'			________________________
'			Calibración de  PARAMETROS
'			------------------------------------------

PMC=0.8
V=2


'              _____________________________
'              Valores de las variables EXOGENAS
'             ----------------------------------------------------
INV=10
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

INV=(1-pmc)*pbi
PRODPOT=PBI
CAP=v*ProdPot

'				Finalmente, volvemos a setear el tamaño de la "muestra" a todo el rango donde vamos a trabajar con el modelo.

smpl @first+1 @last

'			================================
'						Creación del MODELO
'			================================
'				Para garantizarnos que estamos emepezando con un modelo "en blanco", primero borramos el modelo.
'				La opción "noerr" permite al Eviews fallar en el intento de borrar el modelo sin dar como salida un "error" (es decir que si intenta borrar un objeto que no existe, siga ejecutando la rutina igual).

delete(noerr) _ModMR
'				Ahora creamos el objeto modelos y lo llamamos modMR
'				Como se utiliza con frecuencia, le agregamos un guión bajo al principio para que aparezca primero en la vista gráfica del workfile 
'				Esto es así porque muchas veces los modelos son muy grandes y demandan una enorme cantidad de series (vamos a ver más adelante que la cantidad de series se multiplica unas cuantas veces)

model _modMR

'				Este último comando crea el modelo. Si ejecuta el programa hasta acá, debería ver en el Workfile que apareció un objeto, llamado _modMR, y precedido por una "M" en color azul. 

'				tenemos un modelo "vacío", si queremos trabajar con él, debemos incorporar las ecuaciones
'			_______________________
'			Incorporación de Ecuaciones
'			----------------------------------------
'				Una vez creado el modelo, agregamos las ecuaciones

'				Demanda Agregada
_modMR.append DA=cons+inv
'				Consumo
_modMR.append CONS=pmc*pbi(-1)
'				Condición de Equilibrio
_modMR.append PBI=da
'				Ahorro Agregado
_modMR.append AHORRO=pbi-cons
'				Dinámica del stock de capital
_modMR.append CAP=inv(-1)+cap(-1)
'				Capacidad instalada
_modMR.append PRODPOT=cap/v
'				Utilización de la capacidad instalada
_modMR.append U=pbi/prodpot


'              ________________________________
'              Resolución del modelo
'             ---------------------------------------------------------
_modMR.solve



