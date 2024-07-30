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
'                                                  Clase 2 - Tercera Parte
'				----------------------------------------------------------------------
'						Una Adaptaci�n del Modelo Harrod-Domar
'                    ----------------------------------------------------------------------
'                                               Equilibrio de Filo de Navaja
'				========================================
'
'
'
'                    *********************************************************
'                    **                               �ADVERTENCIA!                           **
'                    *********************************************************
'                    ** Este archivo debe ser ejecutado a continuaci�n **
'                    ** del correspondiente a la segunda parte               **
'                   **********************************************************
'
'
'
'
' -***********Comienzo del Programa

'Creaci�n SERIES
series SHOCK
shock.displayname Shock en la Demanda Agregada

'Calibraci�n
'	Primero nos aseguramos estar trabajando en el rango completo de la muestra
smpl @all
'	Luego, introducimos el valor. Dado que la actividad pide que el shock sea de 0 para todo t distinto de 2010, lo seteamos primero igual a cero para todo el rango
shock=0

'Luego, se introduce el shock en 2010
'	Primero se setea la muestra
smpl 2010 2010
'	Luego, se introduce el shock
shock=0.01
'				Finalmente, volvemos a setear el tama�o de la "muestra" a todo el rango donde vamos a trabajar con el modelo.

smpl @first+1 @last
'
'Dado que ya el modelo ya fue creado en un archivo anterior, s�lo hace falta modificar la ecuaci�n que determina la demanda agregada
_modHD.replace DA=(1+shock)*(cons+inv)
'Finalmente, se resuelve el modelo

_modHD.solve


' 
