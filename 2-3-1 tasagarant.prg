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
'                                             Sendero Garantizado
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
' -***********continuaci�n del Programa

'Creaci�n SERIES

series GY
gy.displayname Crecimiento Producto

series GI
gi.displayname Crecimiento Inversi�n

series GK
gk.displayname Crecimiento Capital

'	Primero nos aseguramos estar trabajando en el rango completo de la muestra (excluyendo la observaci�n reservada a las condiciones iniciales
smpl @first+1 @last

'Dado que ya el modelo ya fue creado en un archivo anterior, s�lo hace falta agregar las ecuaciones correspondientes
_modHD.append GK=@pc(cap)
_modHD.append GI=@pc(inv)
_modHD.append GY=@pc(pbi)
'Finalmente, se resuelve el modelo

_modHD.solve

