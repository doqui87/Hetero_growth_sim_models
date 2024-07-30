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
'                                                 Clase 3 - Primera Parte
'				----------------------------------------------------------------------
'                       Cierres Heterodoxos en Modelos de Crecimiento  
'                    ----------------------------------------------------------------------
'                                     Aceleraci�n Crecimiento Aut�nomo
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
' -***********Continuaci�n del Programa
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


