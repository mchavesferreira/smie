;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   seg nov 9 2015
; Processor: ATmega328P
; Compiler:  AVRASM (Proteus)
;====================================================================

;====================================================================
; DEFINITIONS
;====================================================================


;====================================================================
; VARIABLES
;====================================================================
.equ  TempoAgitar1             = 0x100 ; Tempo 
.equ  TempoAgitar2             = 0x101 ; Tempo 
.equ  TempoMolho1            = 0x102 ; Tempo 
.equ  TempoMolho2            = 0x103 ; Tempo 
.equ  TempoCentrifugar      = 0x104 ; Tempo 
.equ  Acucar      = 0x105 ; Tempo 
;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================
 .org 0x00
      ; Reset Vector
      rjmp  Start

;====================================================================
; CODE SEGMENT
;====================================================================
.include "lib328Pv02.inc"
.include "maquina_lavar_biblioteca.inc"

Start:
     LDI R16, 0b00000000	;//carrega R16
     OUT DDRB,R16		;//configura todos os pinos ENTRADA
     LDI R16, 0b00111111
     OUT PORTB, R16  ;  Ativa pull-up
     LDI R16, 0b00011111;//carrega R16
     OUT DDRC,R16		;//configura todos os pinos SAÍDA


;; carrega valores iniciais para tempos

       ldi r16, 3 ; 
       sts TempoAgitar1, r16
       ldi r16, 4 ; 
      sts  TempoAgitar1, r16
       ldi r16, 3 ; 
      sts  TempoMolho1, r16         
       ldi r16, 5 ; 
      sts  TempoMolho2, r16         
       ldi r16, 3 ; 
     sts  TempoCentrifugar, r16

Inicio:
  ; inicializa lcd
	rcall lcd_init	; Inicialização do LCD (VSS=GND VDD=5V VO=GND RS=PD2 RW=GND E=PD3           D4=PD4 D5=PD5 D6=PD6 D7=PD7 A=5V K=GND) 
	
  
  
    rcall BemVindo   ; desvia para rotina mensagem
Principal:      
     SBIC PINB, bt_enter		  ; aguarda botao
     RJMP Principal

; ---------------------------------------------------------------
  rcall EscolhaTamanho   ;; linh 0
  rcall PMG      ;  LINHA 1
tamanhodocopo:
   SBIS PINB, bt_1
   RJMP escolhaP   ; Se bt=0 ou seja pressionado

   SBIS PINB, bt_2
   RJMP escolhaM

   SBIS PINB, bt_3
   RJMP escolhaG

RJMP tamanhodocopo
; ---------------------------------------------------------------
escolhaP:
    mov tempocafe, tempoP
	rjmp valvuladecafe

escolhaM:
	mov tempocafe, tempoM
	rjmp valvuladecafe

escolhaG:
	mov tempocafe, tempoG
	rjmp valvuladecafe
; ---------------------------------------------------------------

; ---------------------------------------------------------------
  rcall EscolhaAcucar   ;; linh 0
  rcall SN      ;  LINHA 1
configuraracucar:
   SBIS PINB, bt_1
   RJMP escolhaSacucar   ; Se bt=0 ou seja pressionado


   SBIS PINB, bt_3
   RJMP escolhaNacucar

RJMP configuraracucar
; ---------------------------------------------------------------
escolhaSacucar:
    ldi R16,1    
    STS Acucar, R16    
    rjmp escolhaLeite

escolhaNacucar:
    ldi R16,0
    STS Acucar, R16 
     rjmp escolhaLeite
; ---------------------------------------------------------------

escolhaLeite:

testarsensorCopo:

testarsensorCartao:

Emoperacao:

prepararcafe:  ;; ligar a valvula "cafe" em funcao "tempocafe"

prepararacucar:   ;; Acucar=0   ou Acucar=1 ligar valvula acucar por tempo
   LDS R16,Acucar
TestazeroNacucar:
    TST R16
    breq Naoacucar  ; zero  R16
    rjmp SIMacucar ; um R16


SIMacucar:
    SBI Valvulaacucar
    ;;;;   tempo
    CBI Valvulaacucar

Naoacucar:
    ;;;;  

prepararleite:

rcall mensagempronto
pronto:
   sbis pinb,sensorcopo
   rjmp pronto

rjmp principal


	 rcall lcd_clear	; Chama rotina limpar o LCD e posicionar na linha 0, coluna 0
	  ldi lcd_col, 0
	  rcall lcd_lin0_col
     rcall imprime_enchendo
Encher:      
     SBI PORTC, valv_encher
     SBIC PINB, sensor_cheio		  ; aguarda  sensor
     RJMP Encher
     CBI PORTC, valv_encher

	rcall lcd_clear	; Chama rotina limpar o LCD e posicionar na linha 0, coluna 0
	  ldi lcd_col, 0
	  rcall lcd_lin0_col
     rcall imprime_agitando

Agitar:
     SBI PORTC, motor_agitar
     lds aux, TempoAgitar1   ; recupera valor da memoria para R16
     mov delay_time,aux
     rcall delay_seconds
    CBI PORTC, motor_agitar

	rcall lcd_clear	; Chama rotina limpar o LCD e posicionar na linha 0, coluna 0

Molho1:
     lds aux, TempoMolho1    ; recupera valor da memoria para R16
     mov delay_time,aux
     rcall delay_seconds

Esvaziar1:
     SBI PORTC, valv_esvaziar 
     SBIC PINB, sensor_vazio		  ; aguarda  sensor
     RJMP Esvaziar1
     CBI PORTC, valv_esvaziar 

Encher2:

Agitar2:

Molho2:

Esvaziar2:

Centrifugar:

Desligatudo:

       Rjmp Inicio


Loop:
    rjmp  Loop











mov lcd_number, aux ; move de R16 para lcd_number
  	 call lcd_write_number	 ; imprime no lcd

    rcall lcd_clear	; Chama rotina limpar o LCD e posicionar na linha 0, coluna 0
	rcall Mensagem_lavar1  ; ; desvia para rotina mensagem

;;;;;;;  posiciona cursor
	ldi lcd_col,0    ;define coluna
	rcall lcd_lin1_col ;define linha 
    ldi lcd_caracter,'T'	  ;; carrega letra entre aspas		
	rcall lcd_write_caracter  ; chama rotina para imprimir caracter
     ldi lcd_caracter,'='
    rcall lcd_write_caracter  ; chama rotina para imprimir caracter
    
     lds aux, TempoAgitar1   ; recupera valor da memoria para R16
     mov lcd_number, aux ; move de R16 para lcd_number
  	 call lcd_write_number	 ; imprime no lcd

     ldi aux, 5                     ; tempo
     mov delay_time,aux
     rcall delay_seconds

    rcall lcd_clear	; Chama rotina limpar o LCD e posicionar na linha 0, coluna 0
	rcall Mensagem_lavar1  ; ; desvia para rotina mensagem


 

    rcall lcd_clear	; Chama rotina limpar o LCD e posicionar na linha 0, coluna 0
    rcall imprime_enchendo












