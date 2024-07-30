'				Universidad Nacional de San Mart�n - UNSAM
'				Instituto de Altos Estudios Sociales - IDAES
'				Maestr�a en Desarrollo Econ�mico  - MDE
'				Escuela de Invierno para Estudiantes de Econom�a
'				"T�picos Avanzados de Econom�a Heterodoxa"

'				Taller de Modelizaci�n
'				Julio de 2016
'				Docentes: Guido Ianni y Nicol�s Zeolla

''				========================================
'                                                 Clase 1 - Segunda Parte
'				----------------------------------------------------------------------
'				                      El Modelo Keynesiano Simple
'                    ----------------------------------------------------------------------
'                      Incremento del Gasto y Paradoja de la Frugalidad
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
'SHOCk 1:

'shock sobre el gasto
smpl 2020 @last
series gasto=20

smpl @first @last


_MKS.solve


'grafico shock aumento del gasto
graph Fig1.line y_0 gasto
fig1.addtext(t,just(c), font(Garamond, 30, b)) Figura 1: Aumento del gasto autonomo

show fig1

'SHOCK 2

'shock sobre la propensi�n marginal a consumir
'paradoja de la frugalidad
'intento ahorrar m�s, disminuye la propensi�n marginal a consumir


smpl 2030 @last
series PMC=0.6

smpl @first @last

_MKS.solve

'grafico de "paradoja de la frugalidad"

graph Fig2.line PMC y_0 ahorro_0 gasto cons_0 
fig2.setelem(1) lcolor(blue) lwidth(1) lpat(1) axis(right)
fig2.addtext(t,just(c), font(Garamond, 30, b)) Figura 2: Paradoja de la frugalidad

show fig2

