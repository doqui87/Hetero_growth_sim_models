'				Universidad Nacional de San Martín - UNSAM
'				Instituto de Altos Estudios Sociales - IDAES
'				Maestría en Desarrollo Económico  - MDE
'				Escuela de Invierno para Estudiantes de Economía
'				"Tópicos Avanzados de Economía Heterodoxa"

'				Taller de Modelización
'				Julio de 2016
'				Docentes: Guido Ianni y Nicolás Zeolla

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
'                    **                               ¡ADVERTENCIA!                           **
'                    *********************************************************
'                    ** Este archivo debe ser ejecutado a continuación **
'                    ** del correspondiente a la primera parte               **
'                   **********************************************************
'
'
' -***********Continuación del Programa
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

'shock sobre la propensión marginal a consumir
'paradoja de la frugalidad
'intento ahorrar más, disminuye la propensión marginal a consumir


smpl 2030 @last
series PMC=0.6

smpl @first @last

_MKS.solve

'grafico de "paradoja de la frugalidad"

graph Fig2.line PMC y_0 ahorro_0 gasto cons_0 
fig2.setelem(1) lcolor(blue) lwidth(1) lpat(1) axis(right)
fig2.addtext(t,just(c), font(Garamond, 30, b)) Figura 2: Paradoja de la frugalidad

show fig2

