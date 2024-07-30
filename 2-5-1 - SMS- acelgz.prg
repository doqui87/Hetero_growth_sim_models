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
'                                                                Clase 3
'				----------------------------------------------------------------------
'				  Cierres en Modelos Heterodoxos de Crecimiento 
'                    ----------------------------------------------------------------------
'                     Supermult. Sraffiano - Aceleración Crec. Autónomo
'				========================================
'
'
'                    *********************************************************
'                    **                               ¡ADVERTENCIA!                           **
'                    *********************************************************
'                    ** Este archivo debe ser ejecutado a continuación **
'                    ** del correspondiente a la primera parte               **
'                   **********************************************************

smpl 2010 @last
gz=0.07
smpl @first+1 @last
_modSMS.scenario "Previsión Perfecta de la Tasa de Crecimiento"
_modSMS.solve
_modSMS.scenario "Expectativas Adaptativas en la Tasa de Crecimiento"
_modSMS.solve


group TC_pf gy_pf gk_pf gi_pf gesp_pf
group uh_pf u_pf h_pf
  
group TC_EA gy_EA gk_EA gi_EA gesp_EA  
group uh_EA u_EA h_EA

smpl @first+7 @first+16
graph FIg1a.line uh_pf
graph Fig1b.line TC_pf
graph FIg1.merge Fig1a Fig1b
fig1.addtext(t,just(c), font(Garamond, 30,b)) Figura 1: Ajuste con Previsión Perfecta

smpl @first+7 @first+35
graph Fig2a.line uh_EA
graph Fig2b.line TC_EA
graph Fig2.merge Fig2a Fig2b
fig2.addtext(t,just(c), font(Garamond, 30, b)) Figura 2: Ajuste con Expectativas Adaptativas


show Fig1
show Fig2

