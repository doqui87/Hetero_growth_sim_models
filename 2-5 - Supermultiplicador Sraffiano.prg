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
'                                                                Clase 3
'				----------------------------------------------------------------------
'				  Cierres en Modelos Heterodoxos de Crecimiento 
'                    ----------------------------------------------------------------------
'                                     Supermultiplicador Sraffiano
'				========================================
'
'
'                    *********************************************************
'                    **                               ¡ADVERTENCIA!                           **
'                    *********************************************************
'                    ** Este archivo debe ser ejecutado a continuación **
'                    ** del correspondiente a la primera parte               **
'                   **********************************************************
'
'
'
' -***********Continuacion del Programa
pagecreate(page=SM) a 2000 2050
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

series PBI
pbi.displayname Producto 

series Z
z.displayname Demanda Autónoma

series CAP
cap.displayname Stock de Capital

series PRODPOT
prodpot.displayname Producto Potencial

series U
u.displayname Utilización de la Capacidad

series PMC
pmc.displayname Propensión a consumir

series INV
inv.displayname Inversión

series GESP
gesp.displayname Crecimiento Esperado de la Demanda


' 				_____________________
'				Creación Series Auxiliares
'				-------------------------------------

series GY
gy.displayname Tasa de Crecimiento del PBI

series GK
gk.displayname Tasa de Crecimiento del Producto Potencial

series GI
gi.displayname Tasa de Crecimiento de la Inversión

series H
h.displayname Participación de la Inversión en el PBI

'			__________________
' 			Creación Parámetros
'			---------------------------------
' 				Creamos los parámetros como si fueran series para tener más control sobre cuándo se pertuba al sistema cambiando el valor del parámetro en el momento exacto en que nosotros queremos.



series CPI
cpi.displayname Propensión a Consumir Capitalistas

series CW
cw.displayname Propensión Consumir Asalariados

series DISTR
distr.displayname Participación Beneficios

series V
v.displayname Relación Capital/Producto

series GAMMA
gamma.displayname Sensibilidad de Inversión

series ALPHA
alpha.displayname Persistencia de las expectativas de crecimiento

series GZ
gz.displayname Crecimiento de la Demanda Autónoma

'			________________________
'			Calibración de  PARAMETROS
'			------------------------------------------

v=2
cpi=0
cw=1
distr=0.5
gz=0.05
gamma=0.05
alpha=0.9


' 				_____________________________
'				Asignación de valores a  EXOGENAS
'				--------------------------------------------------
'					Como este modelo no tiene variables exógenas, 
'					dejamos esta sección en blanco

'				________________________________
'				Determinación de VALORES INICIALES
'				---------------------------------------------------------
'					para determinar los valores iniciales primero seteamos la "muestra" 
'					para eso usaremos la primera observación.

smpl @first @first

'				Luego, asumimos que partimos de una situación de equilibrio.
'				Elegimos el valor para la demanda autónoma

z=1

'				Y, el resto de las variables, las determinamos a partir de dicho valor inicial de forma tal de asegurar el equilibrio en el primer período

pmc=cw+(cpi-cw)*distr
da=z/(1-pmc-v*gz)
pbi=da
ProdPot=PBI
cap=v*prodpot
inv=v*gz*pbi
gesp=gz
gy=gz
u=pbi/prodpot
h=v*gz

'				Finalmente, volvemos a setear el tamaño de la "muestra" a todo el rango donde vamos a trabajar con el modelo.

smpl @first+1 @last



'			================================
'						Creación del MODELO
'			================================
'				Ahora creamos el objeto modelos y lo llamamos modSMS
'				Como se utiliza con frecuencia, le agregamos un guión bajo al principio para que aparezca primero en la vista gráfica del workfile 
'				Esto es así porque muchas veces los modelos son muy grandes y demandan una enorme cantidad de series (vamos a ver más adelante que la cantidad de series se multiplica unas cuantas veces)
'				Para garantizarnos que estamos emepezando con un modelo "en blanco", primero borramos el modelo.
'				La opción "noerr" permite al Eviews fallar en el intento de borrar el modelo sin dar como salida un "error" (es decir que si intenta borrar un objeto que no existe, siga ejecutando la rutina igual).

delete(noerr) _modSMS
model _modSMS
'				Este último comando crea el modelo. Si ejecuta el programa hasta acá, debería ver en el Workfile que apareció un objeto, llamado _modSMS, y precedido por una "M" en color azul. 
'				tenemos un modelo "vacío", si queremos trabajar con él, debemos incorporar las ecuaciones

'				tenemos un modelo "vacío", si queremos trabajar con él, debemos incorporar las ecuaciones
'			_______________________
'			Incorporación de Ecuaciones
'			----------------------------------------
'				Una vez creado el modelo, agregamos las ecuaciones

'				Demanda Agregada
_modSMS.append DA=cons+inv+z
'				Consumo
_modSMS.append CONS=pmc*pbi
'				Condición de equilibrio
_modSMS.append PBI=da
'				Demanda Autónoma
_modSMS.append Z=z(-1)*(1+gz)
'				Dinámica del Stock de Capital
_modSMS.append CAP=inv(-1)+cap(-1)
'				Producto Potencial
_modSMS.append PRODPOT=cap/v
'				Utilización de la capacidad instalada
_modSMS.append U=pbi/prodpot
'				Propensión a consumir de la economía
_modSMS.append PMC=cw+(cpi-cw)*distr
'				Inversión
_modSMS.append INV=cap*(gesp+gamma*(u(-1)-1))
'				Tasas de crecimiento
_modSMS.append Gi = D(inv)/inv(-1)
_modSMS.append Gk = D(cap)/cap(-1)
_modSMS.append Gy = D(pbi)/pbi(-1)
'				Participación de la Inversión en el Producto
_modSMS.append H=inv/pbi

'              _________________________________________________
'              Creación del Escenario con Previsión de Demanda Autónoma
'             ---------------------------------------------------------------------------------------

_modSMS.scenario(n, a=PF) "Previsión Perfecta de la Tasa de Crecimiento"
_modSMS.append gesp=gz
_modSMS.solve


'              __________________________________________
'              Creación del Escenario con Expectativas Adaptativas
'             ---------------------------------------------------------------------------

_modSMS.scenario(n, a=EA) "Expectativas Adaptativas en la Tasa de Crecimiento"
_modSMS.replace gesp=alpha*gesp(-1)+(1-alpha)*gy(-1)
_modSMS.solve


