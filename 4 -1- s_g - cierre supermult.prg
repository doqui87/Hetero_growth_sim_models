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
'                                                                Clase 4
'				----------------------------------------------------------------------
'				  Cierres en Modelos Heterodoxos de Crecimiento 
'                    ----------------------------------------------------------------------
'                                    Modelo de Stop and Go
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
close STOP_AND_GO.wf1
wfcreate(wf=STOP_AND_GO,page=s_g) a 2000 2100
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

series G
g.displayname Gasto Publico

series X
x.displayname exportaciones

series M
m.displayname importaciones

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

series BC
BC.displayname Balance comercial USD

series RES
RES.displayname Reservas USD

series DISTR
distr.displayname Participaci�n Beneficios

series E
E.displayname tipo de cambio real

series rinde
rinde.displayname Rinde Agr�cola

series tierra
tierra.displayname Hectareas Cultivadas

series pf
pf.displayname Precio Soja (USD)



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

series RESPBI
RESPBI.displayname Reservas/PBI


'			__________________
' 			Creaci�n Par�metros
'			---------------------------------
' 				Creamos los par�metros como si fueran series para tener m�s control sobre cu�ndo se pertuba al sistema cambiando el valor del par�metro en el momento exacto en que nosotros queremos.

series GG
gg.displayname Crecimiento de la Demanda Aut�nomaeries 

series GX
gX.displayname Crecimiento de la Demanda Aut�nomaeries 

series mu
mu.displayname elasticidad ingreso de las importaciones

series V
v.displayname Relaci�n Capital/Producto

series CW
cw.displayname Propensi�n Consumir Asalariados

series CPI
cpi.displayname Propensi�n a Consumir Capitalistas

series GAMMA
gamma.displayname Sensibilidad de Inversi�n

series ALPHA
alpha.displayname Persistencia de las expectativas de crecimiento

series DEVA
DEVA.displayname Tasa de devaluaci�n

series DUMMY
DUMMY.displayname Nueva Crisis

series DUMMY_mem
DUMMY_mem.displayname Memoria de Crisis

series margen
margen.displayname Mark-up sobre costos unitarios

'adicionales

'series rinde
'rinde.displayname Rinde producci�n agr�cola
'
'series pf
'pf.displayname Precio Soja
'
'series Tierra
'tierra.displayname Superficie sembrada

'			________________________
'			Calibraci�n de  PARAMETROS
'			------------------------------------------

gg=0.05
gx=0.05

v=2
cpi=0
cw=1

gamma=0.15
alpha=0.9


'nuevos parametros
'queda fijo, m�ximo es 0.03
mu=0.1

dummy=0
deva=0

' 				_____________________________
'				Asignaci�n de valores a  EXOGENAS
'				--------------------------------------------------
'					Como este modelo no tiene variables ex�genas, 
'					dejamos esta secci�n en blanco

'*******************************************************************************

'tipo de cambio nunca puede ser m�s de 3
e=1

margen=0.5

dummy_mem=0

pf=1
tierra=2.5
rinde=0.10


'				________________________________
'				Determinaci�n de VALORES INICIALES
'				---------------------------------------------------------
'					para determinar los valores iniciales primero seteamos la "muestra" 
'					para eso usaremos la primera observaci�n.

smpl @first @first

'				Luego, asumimos que partimos de una situaci�n de equilibrio.
'				Elegimos el valor para la demanda aut�noma

g=1
x=tierra*rinde*pf
m=x
distr=margen*(1+e)/(1+(margen*(1+e)))

'				Y, el resto de las variables, las determinamos a partir de dicho valor inicial de forma tal de asegurar el equilibrio en el primer per�odo
gesp=(x*gx+g*gg)/(x+g)
pmc=cw+(cpi-cw)*distr
da=(g+E*x)/(1-pmc+mu*E-v*gesp)
pbi=da
ProdPot=PBI
cap=v*prodpot
inv=v*gesp*PBI
gy=gg
u=pbi/prodpot
h=v*gg

m=mu*PBI
bc=(x-m)*e
RES=10



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

delete(noerr) _modS_G
model _modS_G
'				Este �ltimo comando crea el modelo. Si ejecuta el programa hasta ac�, deber�a ver en el Workfile que apareci� un objeto, llamado _modSMS, y precedido por una "M" en color azul. 
'				tenemos un modelo "vac�o", si queremos trabajar con �l, debemos incorporar las ecuaciones

'				tenemos un modelo "vac�o", si queremos trabajar con �l, debemos incorporar las ecuaciones
'			_______________________
'			Incorporaci�n de Ecuaciones
'			----------------------------------------
'				Una vez creado el modelo, agregamos las ecuaciones

'				Demanda Agregada
_modS_G.append DA=cons+inv+g+(x-m)*E
'				Consumo
_modS_G.append CONS=pmc*pbi
'				Condici�n de equilibrio
_modS_G.append PBI=da
'				Demanda Aut�noma
_modS_G.append g=g(-1)*(1+gg)

'Sector externo
'exportacion
_modS_G.append x=tierra*rinde*pf
_modS_G.append rinde=rinde(-1)*(1+gx)

'importaciones
_modS_G.append M=mu*pbi

'				Din�mica del Stock de Capital
_modS_G.append CAP=inv(-1)+cap(-1)
'				Producto Potencial
_modS_G.append PRODPOT=cap/v
'				Utilizaci�n de la capacidad instalada
_modS_G.append U=pbi/prodpot
'				Propensi�n a consumir de la econom�a
_modS_G.append PMC=cw+(cpi-cw)*distr
'				Inversi�n
_modS_G.append INV=cap*(gesp+gamma*(u(-1)-1))

'expectativas adaptivas de la inversi�n
_modS_G.append gesp=alpha*gesp(-1)+(1-alpha)*gy(-1)

'balance comercial
_modS_G.append BC=(x-m)

'reservas (balance de pagos)
_modS_G.append RES=BC+RES(-1)

'Distribuci�n
_modS_G.append distr=margen*(1+e)/(1+(margen*(1+e)))

'tipo de cambio
_modS_G.append e=e(-1)*(1+dummy_mem*deva)

'				Tasas de crecimiento
_modS_G.append Gi = D(inv)/inv(-1)
_modS_G.append Gk = D(cap)/cap(-1)
_modS_G.append Gy = D(pbi)/pbi(-1)

'				Participaci�n de la Inversi�n en el Producto
_modS_G.append H=inv/pbi

'reservas/PBI
_modS_G.append RESPBI=RES/PBI



_modS_G.solve


