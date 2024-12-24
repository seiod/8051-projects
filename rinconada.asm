ORG 0000H
AJMP INICIO

ORG 0100H

INICIO:
       MOV P0, #00H
       MOV P1, #00H
       MOV P2, #00H
       MOV P3, #00H
       MOV R0, #255
I1:    ACALL SORTEO
       JB P0.1, I1 ;BOTON DE START
       SETB P0.2 ;LED AMARILLO PARA NO SOLTAR EL BOTON DE START
S1:    CJNE R0, #20, S2
       AJMP GANA1
S2:    CJNE R0, #32, S3
       AJMP GANA2
S3:    CJNE R0, #54, S1
       AJMP GANA3

SORTEO:
D1:    DJNZ R0, GANADOR
       MOV R0, #255
       AJMP SORTEO
GANADOR:
        CJNE R0, #20, C1
        AJMP FSORTEO
C1:     CJNE R0, #31, C2
        AJMP FSORTEO
C2:     CJNE R0, #54, C3
        AJMP FSORTEO
C3:     AJMP D1
FSORTEO: ;FINAL DEL SORTEO
        RET

GANA1:
      ACALL RUTINA_INICIAL
      MOV P1, #00H
      MOV P1, #00000001B


GANA2:
      ACALL RUTINA_INICIAL
      MOV P1, #00H
      MOV P1, #00000010B


GANA3:
      ACALL RUTINA_INICIAL
      MOV P1, #00000100B

RUTINA_INICIAL:
               SETB P0.4 ;ABRIR PUERTAS A CABALLOS
               CLR P0.2 ;APAGA EL LED AMARILLO
               SETB P0.3 ;LED VERDE PARA SOLTAR EL BOTON DE START
RI1:           JNB P0.6, RI1 ;PUERTA TOTALMENTE ABIERTA JUEGO DE ANDS
               CLR P0.4 ;APAGA MOTOR DE APERTURA
               SETB P0.0 ;BUZZER DE COMIENZO DE LA CARRERA
               MOV P1, #00000111B ;SALEN CABALLOS AL MISMO TIEMPO
               ACALL RETARDO_1
               SETB P0.5 ;MOTOR CERRAR LAS PUERTAS
RI2:           JNB P0.7, RI2 ;PUERTAS TOTALMENTE CERRADAS JUEGO DE ANDS
               CLR P0.5 ;APAGO MOTOR DE CIERRE
               CLR P0.0 ;APAGO EL BUZZER
               RET

RETARDO1:
         MOV R5, #100
ER1:     MOV R6, #100
ER2:     MOV R7, #100
ER3:     DJNZ R7, ER3
         DJNZ R6, ER2
         DJNZ R5, ER1
         RET