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
'                                             Sendero Garantizado
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
' -***********continuación del Programa

'Creación SERIES

series GY
gy.displayname Crecimiento Producto

series GI
gi.displayname Crecimiento Inversión

series GK
gk.displayname Crecimiento Capital

'	Primero nos aseguramos estar trabajando en el rango completo de la muestra (excluyendo la observación reservada a las condiciones iniciales
smpl @first+1 @last

'Dado que ya el modelo ya fue creado en un archivo anterior, sólo hace falta agregar las ecuaciones correspondientes
_modHD.append GK=@pc(cap)
_modHD.append GI=@pc(inv)
_modHD.append GY=@pc(pbi)
'Finalmente, se resuelve el modelo

_modHD.solve

