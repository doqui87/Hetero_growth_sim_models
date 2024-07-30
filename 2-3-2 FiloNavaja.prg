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
'                                                  Clase 2 - Tercera Parte
'				----------------------------------------------------------------------
'						Una Adaptación del Modelo Harrod-Domar
'                    ----------------------------------------------------------------------
'                                               Equilibrio de Filo de Navaja
'				========================================
'
'
'
'                    *********************************************************
'                    **                               ¡ADVERTENCIA!                           **
'                    *********************************************************
'                    ** Este archivo debe ser ejecutado a continuación **
'                    ** del correspondiente a la segunda parte               **
'                   **********************************************************
'
'
'
'
' -***********Comienzo del Programa

'Creación SERIES
series SHOCK
shock.displayname Shock en la Demanda Agregada

'Calibración
'	Primero nos aseguramos estar trabajando en el rango completo de la muestra
smpl @all
'	Luego, introducimos el valor. Dado que la actividad pide que el shock sea de 0 para todo t distinto de 2010, lo seteamos primero igual a cero para todo el rango
shock=0

'Luego, se introduce el shock en 2010
'	Primero se setea la muestra
smpl 2010 2010
'	Luego, se introduce el shock
shock=0.01
'				Finalmente, volvemos a setear el tamaño de la "muestra" a todo el rango donde vamos a trabajar con el modelo.

smpl @first+1 @last
'
'Dado que ya el modelo ya fue creado en un archivo anterior, sólo hace falta modificar la ecuación que determina la demanda agregada
_modHD.replace DA=(1+shock)*(cons+inv)
'Finalmente, se resuelve el modelo

_modHD.solve


' 
