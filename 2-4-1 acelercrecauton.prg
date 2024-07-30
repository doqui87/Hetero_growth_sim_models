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
'                                                 Clase 3 - Primera Parte
'				----------------------------------------------------------------------
'                       Cierres Heterodoxos en Modelos de Crecimiento  
'                    ----------------------------------------------------------------------
'                                     Aceleración Crecimiento Autónomo
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
' -***********Continuación del Programa
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


