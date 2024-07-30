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
'												(parte II)
'				----------------------------------------------------------------------
'				  Cierres en Modelos Heterodoxos de Crecimiento 
'                    ----------------------------------------------------------------------
'                                    Modelo de Stop and Go
'				========================================
'

'****************************************
'******************************************

' RECUERDE:
' solo corre si se ejecuto el archivo "Clase 4-1 - S_G cierre supermultiplicador" de programaci�n antes

'***********************************************
'CRISIS DE BALANCE DE PAGOS
'***********************************************

'armamos un nuevo escenario "BRECHA EXTERNA"
'seteo de crecimiento interno por encima del crecimiento interno
'(doble brecha)
'
_modS_G.scenario(n, a=1) "GI > GE"

smpl @first+10 @last
gg=0.06

smpl @first+1 @last

'el BCRA devalua el TCR en un 100% cada vez
deva=1
series dummy_ac=0

_modS_G.solve

' CREACI�N DE "LOOP" : IDENTIFICACI�N DE CRISIS

'vamos a crear la secuencia de ajuste dentro de un mismo escenario

'identificaci�n de los episodios "crisis cambiaria" para el total de las observaciones
'(se corre un "loop" para que repita la secuencia en continuado, es decir, identifique una crisis y resuelva el modelo, luego la que le sigue y resuleva el modelo y as�..)

for !i=1 to 100 

dummy=@recode(res_1(-1)>0 and res_1<0, dummy=0, dummy=1)

dummy_ac=dummy_ac+dummy

dummy_mem=@recode(dummy_ac>0, dummy=0, dummy=1)

_modS_G.solve

next


'graficos
'crisis cambiarias
graph Fig1.line dummy_mem
show fig1

'tasas de crecimiento
graph Fig2.line gesp_1 gy_1
show fig2

'tasa de crecimiento y variaci�n de reservas
series res_var_1=@pc(res_1)
smpl 2020 2090

graph fig3.bar(2) res_var_1 gy_1
fig3.bar(l,a)
fig3.setelem(2) lcolor(blue) lwidth(1) lpat(1) axis(right) 
fig3.axis overlap
show fig3

'tasa de crecimiento y nivel de reservas
graph fig4.bar(2) res_1 gy_1
fig4.bar(l,a)
fig4.setelem(2) lcolor(blue) lwidth(1) lpat(1) axis(right) 
fig4.axis overlap





