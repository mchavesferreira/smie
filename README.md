# Microcontroladores e microprocessadores 

 
## Utilizando Atmega328P para a compreensão e funcionamento de microprocessadores e microcontroladores em geral utilizando a linguagem Assembly.

## Sumário
- [Programas e Simuladores](#simulador-wokwi-e-Atmel-Studio)
- [Mapeamento de Memória](#Mapeamento-de-memória)
- [Configuração de pinos](#Configuração-de-pinos)
- [Diagrama de blocos](#Diagrama-de-blocos)
- [Sistemas de clock](#Sistemas-de-clock)
- [Sistema de Reset](#Sistema-de-Reset)
- [Assembly-primeiro programa](#Assembly-Primeiro-programa)
- [Interrupção Externa](#Interrupção)<BR>
- [Temporização](#Temporização) : Timer 0, Timer 1, Timer 2 e PWM
- [Conversor AD](#Conversor-AD) 
- [Comunições Seriais](#Comunicação-Serial) 
        - [USART]
        - [SPI]
        - [I2C]
- [Memória EEPROM](#Conversor-AD) 


- [Projetos e Programas](#Projetos-e-Programas)
	- [Pisca Led](#Pisca-Led)
	- [Dislplay 7 Segmentos](#Dislplay-7-Segmentos)
	- [Display LCD 16x2](#Display-LCD-16x2)
	- [Maquina de Lavar](#Maquina-de-Lavar)

### SMIE 2022- Projeto Final

## Requisitos
- Utilizar microcontrolador Atmega328P
- Linguagen Assembly
- Montagem prática em matriz de contados(protoboard) utilizando potênciometros como entrada analógica, botões como entradas digitais, e leds como saídas digitais
- Opcionalmente pode-se utilizar sensores e cargas (saídas) reais
- Trabalho em dupla (apenas 1 equipe terá três integrantes já informado).
- Programação com envio de código fonte e simulação em proteus para o email do professor
- Utilizar display LCD 16x2
- Utilizar menu com no mínimo 3 alterações de valores em configuração (tempo, limite, etc...) para uma máquina de processo 
- Reliazar leitura analógica
- Utilizar temporização com interrupção (Timer 0, 1 e 2)
- Complexidade e criatividade será ponderada
- Prazo Trabalho prático: 09/12/2022 (Peso do trabalho na nota final: 40%)
<BR>

<BR>Peso das provas escritas: P1 30%  e  P2 30% (09/12/2022)
<Br>Confira exemplos de <a href=https://github.com/mchavesferreira/smie/tree/main/timer>projetos</a> de ex-alunos matriculados na disciplina: 


## Simulador Wokwi e Atmel Studio

<center><img src=imagens/wokwi_simulador.png></center>

Simulador <a href=https://wokwi.com/projects/341066839950885460>Atmega328P Assembly Online</a>

Teclas de atalho e tutorial para o <a href=https://docs.wokwi.com/pt-BR/guides/diagram-editor> Simulador Wokwi</a><P>

Atmel Studio:<a href=http://studio.download.atmel.com/7.0.2389/as-installer-7.0.2389-full.exe>Atmel Studio 7.0</a><BR>
  
Gravador para firmware .hex utilizando bootloader Arduino: <a href=https://github.com/mchavesferreira/smie/blob/main/hexloader.zip>Hexloader</a>
 
## Mapeamento-de-memória
 
Instruções principais para a movimentação de bytes na memória do Atmega328
<center><img src=https://raw.githubusercontent.com/mchavesferreira/smie/main/imagens/movimentacao_bits_bytes.png></center>
 
## Configuração de pinos

<center><img src=imagens/pinout_atmega328P.png></center>

## Diagrama de blocos
O Atmel® ATmega328P é um microcontrolador CMOS de 8 bits de baixa potência baseado na arquitetura RISC aprimorada AVR®. Ao executar instruções poderosas em um único ciclo de clock, o ATmega328P atinge taxas de transferência de aproximadamente 1MIPS por MHz, permitindo otimizar consumo de energia versus a velocidade de processamento.[1]
<center><img src=imagens/diagrama_blocos.png></center

O núcleo AVR® combina um rico conjunto de instruções com 32 registradores de trabalho de uso geral(GPR). Todos os 32 registradores são conectados diretamente à unidade lógica aritmética (ULA), permitindo que dois registradores independentes sejam acessados em uma única instrução executada em um ciclo de clock. A arquitetura resultante é mais eficiente em termos de código, ao mesmo tempo em que alcança rendimentos até dez vezes mais rápidos do que os microcontroladores CISC convencionais.
O Atmel® ATmega328P fornece os seguintes recursos: 32K bytes de flash programável no sistema com recursos de leitura durante a gravação, 1K bytes EEPROM, 2K bytes SRAM, 23 linhas de E/S de uso geral, 32 registradores de trabalho de uso geral, três temporizadores flexíveis /Contadores com modos de comparação, interrupções internas e externas, um USART programável serial, uma interface serial de 2 fios orientada a byte, uma porta serial SPI, um ADC de 6 canais e 10 bits (8 canais em pacotes TQFP e QFN/MLF) , um temporizador de watchdog programável com oscilador interno e cinco modos de economia de energia selecionáveis por software. O modo ocioso para a CPU enquanto permite que a SRAM, Temporizador/Contadores, USART, interface serial de 2 fios, porta SPI e sistema de interrupção continuem funcionando. O modo de desligamento salva o conteúdo do registro, mas congela o oscilador, desabilitando todas as outras funções do chip até a próxima interrupção ou reinicialização do hardware. No modo de economia de energia, o temporizador assíncrono continua a funcionar, permitindo que o usuário mantenha uma base de temporizador enquanto o restante do dispositivo está dormindo. O modo de redução de ruído ADC para a CPU e todos os módulos de E/S, exceto temporizador assíncrono e ADC, para minimizar o ruído de comutação durante as conversões ADC. No modo de espera, o oscilador de cristal/ressonador está funcionando enquanto o restante do dispositivo está dormindo. Isto permite um arranque muito rápido combinado com um baixo consumo de energia.[1]


Core CPU
A principal função do núcleo da CPU (core CPU) é garantir a execução correta do programa. A CPU deve, portanto, ser capaz de acessar memórias, realizar cálculos, controlar periféricos e lidar com interrupções.

<center><img src=imagens/core_cpu.png></center
Diagrama de Blocos da Arquitetura AVR

Para maximizar o desempenho e o paralelismo, o AVR usa uma arquitetura harvard – com memórias e barramentos separados para programa e dados. As instruções na memória do programa são executadas com um pipelining de nível único. Enquanto uma instrução está sendo executada, a próxima instrução é pré-buscada na memória do programa. Este conceito permite que as instruções sejam executadas em cada ciclo de clock. A memória do programa é uma memória flash reprogramável no sistema.[1]

## Sistemas de clock

Principais sistemas de clock do AVR® e sua distribuição. Todos os clock não precisam estar ativos em um determinado momento. Para reduzir o consumo de energia, os relógios dos módulos que não estão sendo usados podem ser interrompidos usando diferentes modos de suspensão, conforme descrito na Seção "Modes Sleep Gerenciamento de energia e modos de suspensão". 
<center><img src=imagens/distribuicaoclock_f_8_1.png></center>
Para maximizar o desempenho e o paralelismo, o AVR usa uma arquitetura harvard – com memórias e barramentos separados para programa e dados. As instruções na memória do programa são executadas com um pipelining de nível único. Enquanto uma instrução está sendo executada, a próxima instrução é pré-buscada na memória do programa. Este conceito permite que as instruções sejam executadas em cada ciclo de clock. A memória do programa é uma memória flash reprogramável no sistema.[1]

## Sistema de Reset

<center><img src=imagens/sistema_reset.png>Lógica Reset</center>

Durante o reset, todos os registradores de E/S são ajustados para seus valores iniciais, e o programa inicia a execução a partir do vetor de reset. Para o Atmel® ATmega328P, a instrução colocada no vetor de reset deve ser uma instrução RJMP – salto relativo – para a rotina de manipulação de reset. Se o programa nunca habilita uma fonte de interrupção, os vetores de interrupção não são usados e o código de programa regular pode ocupar nesses locais. Este também é o caso se o vetor de reset estiver na seção de aplicação enquanto os vetores de interrupção estiverem na seção de inicialização. As portas de E/S do AVR® são imediatamente redefinidas para seu estado inicial quando uma fonte de redefinição fica ativa. Isso não requer que nenhuma fonte de relógio esteja em execução. Após todas as fontes de reset ficarem inativas, um contador de atraso é invocado, estendendo o reset interno. Isso permite que a potência atinja um nível estável antes do início da operação normal. O tempo limite do contador de atraso é definido pelo usuário através dos fusíveis SUT e CKSEL. 

## Assembly Primeiro programa
	
Exemplo de um programa para controle de uma caixa d'agua.
<BR>Defina pinos de entrada e saída. As entradas com push button aterradas e  pull up ativos. O Programa aguarda “Start” ser pressionado, que liga a  Valvula 1 até que sensor cheio seja acionado. O misturador é acionado  por2 segundos. Esvazia-se o tanque até o sensor vazio ser acionado, retornando ao estado inicial. Considere clock 16Mhz.
<br><BR>Solução:
<br>Para que servem e quais são os registradores de I/O de um AVR Atmega?  Os registradores de IO  funcionam para configurar, ler e escrever cada  pino das portas  do microcontrolador, cada bit representa um pino:  DDRx  quando em 0=entrada e 1=saída. PINx para a leitura do pino quando este é  definido com entrada; PORTx escreve na saída se o pino é definido como  saída ou ativa pull-up se o pino é definido como entrada.
	<Br>
<details><summary>Ilustrando o primeiro programa (clique)</summary>
<p>
<br><img src=imagens/oprojeto.jpg>
<br><img src=imagens/configuracaopinos.jpg>
<br><img src=imagens/inicio.jpg>
<br><img src=imagens/principal.jpg>
<br><img src=imagens/encher.jpg>
<br><img src=imagens/misturar.jpg>
<br><img src=imagens/esvaziar.jpg>
<br><img src=imagens/atraso.jpg>
</p>
</details>
	
Código para o primeiro programa
```java
//--------------------------------------------------------------------------- //
// EXEMPLO 					  //	
//--------------------------------------------------------------------------- //


.ORG 0x000				

INICIO:
     LDI R19, 0b00000111	//carrega R19 
     OUT DDRB,R19		//configura todos os pinos
     LDI R19, 0b00111000
     OUT PORTB, R19
; aguarda botao start
PRINCIPAL:      
     SBIC PINB,5		
     RJMP Principal
     RJMP ENCHER

; Liga válvula aguarda sensor cheio
ENCHER:
    SBI PORTB,0
    SBIC PINB,3
    RJMP ENCHER
    RJMP MISTURAR

; desliga V1, liga misturador por 2 seg. 
MISTURAR:
    CBI PORTB,0
    SBI PORTB,2
    RCALL ATRASO 
    RCALL ATRASO 
    CBI PORTB, 2
    RJMP ESVAZIAR

; Liga válvula 2 aguarda sensor vazio
ESVAZIAR:
    SBI PORTB,1
    SBIC PINB,4
    RJMP ESVAZIAR
    CBI PORTB,1
    RJMP PRINCIPAL
; .  .    .   .    .    .    .    .   .     .   
; rotina de atraso 1 segundo. 
ATRASO:	
      LDI R19,80	
volta:		
      DEC  R17	
      BRNE volta
      DEC  R18	
      BRNE volta
      DEC  R19
      BRNE volta
      RET
```

## Interrupção
	
### Interrupção Externa

Slide, código para ativação de Int0 e Int1
<a href=https://github.com/mchavesferreira/smie/tree/main/interrupcao>Exemplo Interrupção externa</a>
	
## Temporização
 
### Projetos e Programas utilizando Timer 0 e Timer 1 e PWM
<a href=https://github.com/mchavesferreira/smie/tree/main/timer>Códigos</a> utilizando temporização e PWM
<BR>

## Conversor AD
Código para conversão AD utilizando periférico interno
<a href=https://github.com/mchavesferreira/smie/tree/main/conversor_ad>Saiba mais sobre o conversor AD</a>

## Comunicação Serial

Comunicação UART 

<a href=https://github.com/mchavesferreira/smie/tree/main/serial>Saiba mais sobre a comunicação serial</a>

### Pisca Led

<details><summary>Código Exemplo Pisca Led</summary>
<p>

```ruby  
*/
//--------------------------------------------------------------------------- //
//		Fonte: AVR e Arduino: Técnicas de Projeto, 2a ed. - 2012.					  //	
//--------------------------------------------------------------------------- //

.equ LED   = PB5  		//LED é o substituto de PB5 na programação 

.ORG 0x000				//endereço de início de escrita do código 
rjmp INICIO
.include "lib328Pv01.inc"
INICIO:
	LDI R16,0xFF		//carrega R16 com o valor 0xFF
	OUT DDRB,R16		//configura todos os pinos do PORTB como saída

PRINCIPAL:
      SBI PORTB, LED		//coloca o pino PB5 em 5V
      ldi delay_time, 2 	; Carrega delay_time com
      rcall delay_seconds	; Chama rotina de atraso
	 CBI PORTB, LED 	//coloca o pino PB5 em 0V
	 RCALL ATRASO		//chama a sub-rotina de atraso
	 RJMP PRINCIPAL 	//volta para PRINCIPAL


ATRASO:					//atraso de aprox. 200ms
	LDI R19,16	
 volta:		
	DEC  R17			//decrementa R17, começa com 0x00
	BRNE volta 			//enquanto R17 > 0 fica decrementando R17
	DEC  R18			//decrementa R18, começa com 0x00
	BRNE volta			//enquanto R18 > 0 volta decrementar R18
	DEC  R19			//decrementa R19
	BRNE volta			//enquanto R19 > 0 vai para volta
	RET	
```
</p>
</details> 

Simulação:
<a href=https://wokwi.com/projects/341066839950885460> Pisca Led</a><br>
 
### Dislplay 7 Segmentos
	
### Display LCD 16x2
	
Montagem Exemplo 4, esteira com display LCD

<img src=imagens/lcd_simulador.png>
	
	- LCD  > AVR (arduino);
	- RS > PD2 (9)
	- Enable > PD (8)
  
Simulação online utilizando LCD16x2: <a href=https://wokwi.com/projects/342964449732198994>Exemplo LCD </a>

### Maquina de Lavar	
	
Exemplo Maquina de Lavar
	
<a href=https://github.com/mchavesferreira/smie/tree/main/exemplo_5_LCD_maquina_lavar><img src=imagens/maquinadelavar.png border=0>
Maquina de lavar </a>
	
Código AVR assembly
<a href=https://wokwi.com/projects/341106129478091346>Simulação Maquina de lavar</a> (woki)

Referências:
[1] Atmega 328P 8-bit AVR Microcontroller with 32K Bytes In-System Programmable Flash - Datasheet
	
[2] <a href=https://github.com/mchavesferreira/mcr/blob/main/dicas%20de%20projetos/Dicas%20para%20projetos.pdf>Dicas de projeto</a>

