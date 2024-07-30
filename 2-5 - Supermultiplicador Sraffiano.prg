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
'                                                                Clase 3
'				----------------------------------------------------------------------
'				  Cierres en Modelos Heterodoxos de Crecimiento 
'                    ----------------------------------------------------------------------
'                                     Supermultiplicador Sraffiano
'				========================================
'
'
'                    *********************************************************
'                    **                               �ADVERTENCIA!                           **
'                    *********************************************************
'                    ** Este archivo debe ser ejecutado a continuaci�n **
'                    ** del correspondiente a la primera parte               **
'                   **********************************************************
'
'
'
' -***********Continuacion del Programa
pagecreate(page=SM) a 2000 2050
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

series PBI
pbi.displayname Producto 

series Z
z.displayname Demanda Aut�noma

series CAP
cap.displayname Stock de Capital

series PRODPOT
prodpot.displayname Producto Potencial

series U
u.displayname Utilizaci�n de la Capacidad

series PMC
pmc.displayname Propensi�n a consumir

series INV
inv.displayname Inversi�n

series GESP
gesp.displayname Crecimiento Esperado de la Demanda


' 				_____________________
'				Creaci�n Series Auxiliares
'				-------------------------------------

series GY
gy.displayname Tasa de Crecimiento del PBI

series GK
gk.displayname Tasa de Crecimiento del Producto Potencial

series GI
gi.displayname Tasa de Crecimiento de la Inversi�n

series H
h.displayname Participaci�n de la Inversi�n en el PBI

'			__________________
' 			Creaci�n Par�metros
'			---------------------------------
' 				Creamos los par�metros como si fueran series para tener m�s control sobre cu�ndo se pertuba al sistema cambiando el valor del par�metro en el momento exacto en que nosotros queremos.



series CPI
cpi.displayname Propensi�n a Consumir Capitalistas

series CW
cw.displayname Propensi�n Consumir Asalariados

series DISTR
distr.displayname Participaci�n Beneficios

series V
v.displayname Relaci�n Capital/Producto

series GAMMA
gamma.displayname Sensibilidad de Inversi�n

series ALPHA
alpha.displayname Persistencia de las expectativas de crecimiento

series GZ
gz.displayname Crecimiento de la Demanda Aut�noma

'			________________________
'			Calibraci�n de  PARAMETROS
'			------------------------------------------

v=2
cpi=0
cw=1
distr=0.5
gz=0.05
gamma=0.05
alpha=0.9


' 				_____________________________
'				Asignaci�n de valores a  EXOGENAS
'				--------------------------------------------------
'					Como este modelo no tiene variables ex�genas, 
'					dejamos esta secci�n en blanco

'				________________________________
'				Determinaci�n de VALORES INICIALES
'				---------------------------------------------------------
'					para determinar los valores iniciales primero seteamos la "muestra" 
'					para eso usaremos la primera observaci�n.

smpl @first @first

'				Luego, asumimos que partimos de una situaci�n de equilibrio.
'				Elegimos el valor para la demanda aut�noma

z=1

'				Y, el resto de las variables, las determinamos a partir de dicho valor inicial de forma tal de asegurar el equilibrio en el primer per�odo

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

'				Finalmente, volvemos a setear el tama�o de la "muestra" a todo el rango donde vamos a trabajar con el modelo.

smpl @first+1 @last



'			================================
'						Creaci�n del MODELO
'			================================
'				Ahora creamos el objeto modelos y lo llamamos modSMS
'				Como se utiliza con frecuencia, le agregamos un gui�n bajo al principio para que aparezca primero en la vista gr�fica del workfile 
'				Esto es as� porque muchas veces los modelos son muy grandes y demandan una enorme cantidad de series (vamos a ver m�s adelante que la cantidad de series se multiplica unas cuantas veces)
'				Para garantizarnos que estamos emepezando con un modelo "en blanco", primero borramos el modelo.
'				La opci�n "noerr" permite al Eviews fallar en el intento de borrar el modelo sin dar como salida un "error" (es decir que si intenta borrar un objeto que no existe, siga ejecutando la rutina igual).

delete(noerr) _modSMS
model _modSMS
'				Este �ltimo comando crea el modelo. Si ejecuta el programa hasta ac�, deber�a ver en el Workfile que apareci� un objeto, llamado _modSMS, y precedido por una "M" en color azul. 
'				tenemos un modelo "vac�o", si queremos trabajar con �l, debemos incorporar las ecuaciones

'				tenemos un modelo "vac�o", si queremos trabajar con �l, debemos incorporar las ecuaciones
'			_______________________
'			Incorporaci�n de Ecuaciones
'			----------------------------------------
'				Una vez creado el modelo, agregamos las ecuaciones

'				Demanda Agregada
_modSMS.append DA=cons+inv+z
'				Consumo
_modSMS.append CONS=pmc*pbi
'				Condici�n de equilibrio
_modSMS.append PBI=da
'				Demanda Aut�noma
_modSMS.append Z=z(-1)*(1+gz)
'				Din�mica del Stock de Capital
_modSMS.append CAP=inv(-1)+cap(-1)
'				Producto Potencial
_modSMS.append PRODPOT=cap/v
'				Utilizaci�n de la capacidad instalada
_modSMS.append U=pbi/prodpot
'				Propensi�n a consumir de la econom�a
_modSMS.append PMC=cw+(cpi-cw)*distr
'				Inversi�n
_modSMS.append INV=cap*(gesp+gamma*(u(-1)-1))
'				Tasas de crecimiento
_modSMS.append Gi = D(inv)/inv(-1)
_modSMS.append Gk = D(cap)/cap(-1)
_modSMS.append Gy = D(pbi)/pbi(-1)
'				Participaci�n de la Inversi�n en el Producto
_modSMS.append H=inv/pbi

'              _________________________________________________
'              Creaci�n del Escenario con Previsi�n de Demanda Aut�noma
'             ---------------------------------------------------------------------------------------

_modSMS.scenario(n, a=PF) "Previsi�n Perfecta de la Tasa de Crecimiento"
_modSMS.append gesp=gz
_modSMS.solve


'              __________________________________________
'              Creaci�n del Escenario con Expectativas Adaptativas
'             ---------------------------------------------------------------------------

_modSMS.scenario(n, a=EA) "Expectativas Adaptativas en la Tasa de Crecimiento"
_modSMS.replace gesp=alpha*gesp(-1)+(1-alpha)*gy(-1)
_modSMS.solve


