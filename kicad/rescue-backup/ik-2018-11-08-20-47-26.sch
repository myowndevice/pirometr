EESchema Schematic File Version 2
LIBS:74xgxx
LIBS:74xx
LIBS:Altera
LIBS:ESD_Protection
LIBS:LEM
LIBS:Lattice
LIBS:Oscillators
LIBS:Power_Management
LIBS:RFSolutions
LIBS:Worldsemi
LIBS:Xicor
LIBS:Zilog
LIBS:ac-dc
LIBS:actel
LIBS:adc-dac
LIBS:allegro
LIBS:analog_devices
LIBS:analog_switches
LIBS:atmel
LIBS:audio
LIBS:battery_management
LIBS:bbd
LIBS:bosch
LIBS:brooktre
LIBS:cmos4000
LIBS:cmos_ieee
LIBS:conn
LIBS:contrib
LIBS:cypress
LIBS:dc-dc
LIBS:device
LIBS:digital-audio
LIBS:diode
LIBS:display
LIBS:dsp
LIBS:elec-unifil
LIBS:ftdi
LIBS:gennum
LIBS:graphic_symbols
LIBS:hc11
LIBS:infineon
LIBS:intel
LIBS:interface
LIBS:intersil
LIBS:ir
LIBS:leds
LIBS:linear
LIBS:logic_programmable
LIBS:maxim
LIBS:mechanical
LIBS:memory
LIBS:microchip
LIBS:microchip_dspic33dsc
LIBS:microchip_pic10mcu
LIBS:microchip_pic12mcu
LIBS:microchip_pic16mcu
LIBS:microchip_pic18mcu
LIBS:microchip_pic24mcu
LIBS:microchip_pic32mcu
LIBS:microcontrollers
LIBS:modules
LIBS:motor_drivers
LIBS:motorola
LIBS:motors
LIBS:msp430
LIBS:nordicsemi
LIBS:nxp
LIBS:nxp_armmcu
LIBS:onsemi
LIBS:opto
LIBS:philips
LIBS:power
LIBS:powerint
LIBS:pspice
LIBS:references
LIBS:regul
LIBS:relays
LIBS:rfcom
LIBS:sensors
LIBS:silabs
LIBS:siliconi
LIBS:stm32
LIBS:stm8
LIBS:supertex
LIBS:switches
LIBS:texas
LIBS:transf
LIBS:transistors
LIBS:triac_thyristor
LIBS:ttl_ieee
LIBS:valves
LIBS:video
LIBS:wiznet
LIBS:xilinx
LIBS:zetex
LIBS:ik-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L STM8S003F3P IC1
U 1 1 58A70280
P 3800 2900
F 0 "IC1" H 2650 3700 50  0000 L CNN
F 1 "STM8S003F3P" H 2650 3600 50  0000 L CNN
F 2 "Housings_SSOP:SSOP-20_4.4x6.5mm_Pitch0.65mm" H 2650 2100 50  0000 L CIN
F 3 "" H 3750 2500 50  0000 C CNN
	1    3800 2900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 58A707C0
P 3800 3900
F 0 "#PWR01" H 3800 3650 50  0001 C CNN
F 1 "GND" H 3800 3750 50  0000 C CNN
F 2 "" H 3800 3900 50  0000 C CNN
F 3 "" H 3800 3900 50  0000 C CNN
	1    3800 3900
	1    0    0    -1  
$EndComp
$Comp
L C_Small C1
U 1 1 58A707E8
P 2350 3600
F 0 "C1" H 2360 3670 50  0000 L CNN
F 1 "10uf" H 2360 3520 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 2350 3600 50  0001 C CNN
F 3 "" H 2350 3600 50  0000 C CNN
	1    2350 3600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 58A7080F
P 2350 3800
F 0 "#PWR02" H 2350 3550 50  0001 C CNN
F 1 "GND" H 2350 3650 50  0000 C CNN
F 2 "" H 2350 3800 50  0000 C CNN
F 3 "" H 2350 3800 50  0000 C CNN
	1    2350 3800
	1    0    0    -1  
$EndComp
$Comp
L C_Small C2
U 1 1 58A708AB
P 3950 1800
F 0 "C2" H 3960 1870 50  0000 L CNN
F 1 "1u" H 3960 1720 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 3950 1800 50  0001 C CNN
F 3 "" H 3950 1800 50  0000 C CNN
	1    3950 1800
	0    1    1    0   
$EndComp
$Comp
L C_Small C3
U 1 1 58A708E2
P 3950 2000
F 0 "C3" H 3960 2070 50  0000 L CNN
F 1 "100n" H 3960 1920 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 3950 2000 50  0001 C CNN
F 3 "" H 3950 2000 50  0000 C CNN
	1    3950 2000
	0    1    1    0   
$EndComp
$Comp
L GND #PWR03
U 1 1 58A7099D
P 4200 1800
F 0 "#PWR03" H 4200 1550 50  0001 C CNN
F 1 "GND" H 4200 1650 50  0000 C CNN
F 2 "" H 4200 1800 50  0000 C CNN
F 3 "" H 4200 1800 50  0000 C CNN
	1    4200 1800
	1    0    0    -1  
$EndComp
Text Label 5300 2900 0    60   ~ 0
sda
Text Label 5750 2800 0    60   ~ 0
scl
$Comp
L NCP551 U1
U 1 1 58A72287
P 3800 6600
F 0 "U1" H 3700 6050 60  0000 C CNN
F 1 "NCP551!!" H 3850 6550 60  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-23-5_HandSoldering" H 3800 6600 60  0001 C CNN
F 3 "" H 3800 6600 60  0000 C CNN
	1    3800 6600
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR04
U 1 1 58A7232D
P 4650 6800
F 0 "#PWR04" H 4650 6650 50  0001 C CNN
F 1 "VDD" H 4650 6950 50  0000 C CNN
F 2 "" H 4650 6800 50  0000 C CNN
F 3 "" H 4650 6800 50  0000 C CNN
	1    4650 6800
	0    1    1    0   
$EndComp
$Comp
L C_Small C5
U 1 1 58A7239B
P 4350 6700
F 0 "C5" H 4360 6770 50  0000 L CNN
F 1 "1uf" H 4360 6620 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 4350 6700 50  0001 C CNN
F 3 "" H 4350 6700 50  0000 C CNN
	1    4350 6700
	1    0    0    -1  
$EndComp
$Comp
L C_Small C4
U 1 1 58A723FB
P 3200 6700
F 0 "C4" H 3210 6770 50  0000 L CNN
F 1 "1uf" H 3210 6620 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 3200 6700 50  0001 C CNN
F 3 "" H 3200 6700 50  0000 C CNN
	1    3200 6700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 58A724FF
P 3200 6450
F 0 "#PWR05" H 3200 6200 50  0001 C CNN
F 1 "GND" H 3200 6300 50  0000 C CNN
F 2 "" H 3200 6450 50  0000 C CNN
F 3 "" H 3200 6450 50  0000 C CNN
	1    3200 6450
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR06
U 1 1 58A7256B
P 3900 7400
F 0 "#PWR06" H 3900 7150 50  0001 C CNN
F 1 "GND" H 3900 7250 50  0000 C CNN
F 2 "" H 3900 7400 50  0000 C CNN
F 3 "" H 3900 7400 50  0000 C CNN
	1    3900 7400
	1    0    0    -1  
$EndComp
Text Label 7450 4450 3    60   ~ 0
a
Text Label 7450 4550 3    60   ~ 0
b
Text Label 7450 4650 3    60   ~ 0
c
Text Label 7450 4750 3    60   ~ 0
d
Text Label 7450 4850 3    60   ~ 0
e
Text Label 7450 4950 3    60   ~ 0
f
Text Label 7450 5050 3    60   ~ 0
g
Text Label 7450 5150 3    60   ~ 0
dp
Text Label 2300 3000 0    60   ~ 0
a
Text Label 2300 2800 2    60   ~ 0
b
Text Label 5250 3300 0    60   ~ 0
c
Text Label 5250 3500 0    60   ~ 0
d
Text Label 5100 2500 0    60   ~ 0
e
Text Label 5200 2400 0    60   ~ 0
f
Text Label 5550 3100 0    60   ~ 0
g
Text Label 5250 3400 0    60   ~ 0
dp
Text Label 10650 4850 0    60   ~ 0
c1
Text Label 10650 4950 0    60   ~ 0
c2
Text Label 10650 5050 0    60   ~ 0
c3
Text Label 2300 3200 0    60   ~ 0
c1
Text Label 2300 3100 0    60   ~ 0
c2
Text Label 2300 2900 0    60   ~ 0
c3
$Comp
L VDD #PWR07
U 1 1 58C50455
P 3800 1550
F 0 "#PWR07" H 3800 1400 50  0001 C CNN
F 1 "VDD" H 3800 1700 50  0000 C CNN
F 2 "" H 3800 1550 50  0000 C CNN
F 3 "" H 3800 1550 50  0000 C CNN
	1    3800 1550
	1    0    0    -1  
$EndComp
Text Label 2100 2700 0    60   ~ 0
prg
Wire Wire Line
	3800 3800 3800 3900
Wire Wire Line
	2350 3700 2350 3800
Wire Wire Line
	2500 3500 2350 3500
Wire Wire Line
	3850 1800 3850 2000
Wire Wire Line
	3800 1550 3800 2100
Wire Wire Line
	3800 1800 3850 1800
Wire Wire Line
	4050 2000 4050 1800
Wire Wire Line
	4050 1800 4150 1800
Wire Wire Line
	5100 2800 5750 2800
Wire Wire Line
	5100 2900 5300 2900
Wire Wire Line
	2100 2700 2500 2700
Wire Wire Line
	2950 6800 3400 6800
Wire Wire Line
	2950 6450 2950 6800
Connection ~ 3200 6800
Wire Wire Line
	3200 6600 3200 6450
Wire Wire Line
	3900 7300 3900 7400
Wire Wire Line
	4200 6800 4650 6800
Connection ~ 4350 6800
Wire Wire Line
	4350 6600 4350 6550
Wire Wire Line
	7550 4450 7450 4450
Wire Wire Line
	7450 4550 7550 4550
Wire Wire Line
	7550 4650 7450 4650
Wire Wire Line
	7550 4750 7450 4750
Wire Wire Line
	7550 4850 7450 4850
Wire Wire Line
	7550 4950 7450 4950
Wire Wire Line
	7550 5050 7450 5050
Wire Wire Line
	7550 5150 7450 5150
Wire Wire Line
	2300 3200 2500 3200
Wire Wire Line
	2300 3100 2500 3100
Wire Wire Line
	2300 3000 2500 3000
Wire Wire Line
	5100 3100 5300 3100
Wire Wire Line
	5250 3200 5100 3200
Wire Wire Line
	5250 3300 5100 3300
Wire Wire Line
	5250 3400 5100 3400
Wire Wire Line
	5250 3500 5100 3500
Wire Wire Line
	2500 2900 2300 2900
Connection ~ 3800 1800
Wire Wire Line
	2500 2800 2300 2800
Wire Wire Line
	4200 1800 4100 1800
Connection ~ 4100 1800
Wire Wire Line
	5200 2400 5100 2400
Wire Wire Line
	1550 6450 2950 6450
$Comp
L Conn_01x02 J3
U 1 1 5A3630A1
P 1350 6550
F 0 "J3" H 1350 6650 50  0000 C CNN
F 1 "bat" H 1350 6350 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x02_Pitch2.54mm" H 1350 6550 50  0001 C CNN
F 3 "" H 1350 6550 50  0001 C CNN
	1    1350 6550
	-1   0    0    1   
$EndComp
$Comp
L Conn_01x01 J4
U 1 1 5A364C8E
P 2300 2400
F 0 "J4" H 2300 2500 50  0000 C CNN
F 1 "Res" H 2300 2300 50  0000 C CNN
F 2 "myowndevice:wirepad_mini" H 2300 2400 50  0001 C CNN
F 3 "" H 2300 2400 50  0001 C CNN
	1    2300 2400
	-1   0    0    1   
$EndComp
$Comp
L CA56-12EWA U2
U 1 1 5A4E85CB
P 8650 4750
F 0 "U2" H 7700 5200 50  0000 C CNN
F 1 "CA56-12EWA" H 9480 5200 50  0000 C CNN
F 2 "myowndevice:indicator_3cif" H 8650 4150 50  0001 C CNN
F 3 "" H 8270 4780 50  0001 C CNN
	1    8650 4750
	1    0    0    -1  
$EndComp
Text Label 8600 1400 2    60   ~ 0
scl
Text Label 8600 1200 2    60   ~ 0
sda
$Comp
L VDD #PWR09
U 1 1 5A4E7F72
P 7850 1500
F 0 "#PWR09" H 7850 1350 50  0001 C CNN
F 1 "VDD" H 7850 1650 50  0000 C CNN
F 2 "" H 7850 1500 50  0000 C CNN
F 3 "" H 7850 1500 50  0000 C CNN
	1    7850 1500
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR010
U 1 1 5A4E8149
P 8250 1750
F 0 "#PWR010" H 8250 1500 50  0001 C CNN
F 1 "GND" H 8250 1600 50  0000 C CNN
F 2 "" H 8250 1750 50  0000 C CNN
F 3 "" H 8250 1750 50  0000 C CNN
	1    8250 1750
	1    0    0    -1  
$EndComp
$Comp
L C_Small C6
U 1 1 5A4E8410
P 8050 1600
F 0 "C6" H 8060 1670 50  0000 L CNN
F 1 "100n" H 8060 1520 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 8050 1600 50  0001 C CNN
F 3 "" H 8050 1600 50  0000 C CNN
	1    8050 1600
	-1   0    0    1   
$EndComp
Connection ~ 8050 1500
Wire Wire Line
	8050 1700 8350 1700
Wire Wire Line
	8250 1700 8250 1750
Wire Wire Line
	8350 1700 8350 1600
Connection ~ 8250 1700
Text Label 5800 6650 0    60   ~ 0
scl
Text Label 5800 6800 0    60   ~ 0
sda
$Comp
L R_Small R3
U 1 1 5A4E8E73
P 6150 6650
F 0 "R3" H 6180 6670 50  0000 L CNN
F 1 "3k" H 6180 6610 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 6150 6650 50  0001 C CNN
F 3 "" H 6150 6650 50  0001 C CNN
	1    6150 6650
	0    1    1    0   
$EndComp
$Comp
L R_Small R4
U 1 1 5A4E8EFB
P 6150 6800
F 0 "R4" H 6180 6820 50  0000 L CNN
F 1 "3k" H 6180 6760 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 6150 6800 50  0001 C CNN
F 3 "" H 6150 6800 50  0001 C CNN
	1    6150 6800
	0    1    1    0   
$EndComp
$Comp
L VDD #PWR011
U 1 1 5A4E90BA
P 6500 6650
F 0 "#PWR011" H 6500 6500 50  0001 C CNN
F 1 "VDD" H 6500 6800 50  0000 C CNN
F 2 "" H 6500 6650 50  0000 C CNN
F 3 "" H 6500 6650 50  0000 C CNN
	1    6500 6650
	1    0    0    -1  
$EndComp
Wire Wire Line
	6250 6650 6500 6650
Wire Wire Line
	6250 6800 6500 6800
Wire Wire Line
	6500 6800 6500 6650
Wire Wire Line
	5800 6650 6050 6650
Wire Wire Line
	5800 6800 6050 6800
Wire Wire Line
	1550 6550 1650 6550
Text Label 2600 5750 0    60   ~ 0
knvkl
$Comp
L R_Small R2
U 1 1 5A4EBD19
P 3250 7100
F 0 "R2" H 3280 7120 50  0000 L CNN
F 1 "50k" H 3280 7060 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 3250 7100 50  0001 C CNN
F 3 "" H 3250 7100 50  0001 C CNN
	1    3250 7100
	-1   0    0    1   
$EndComp
Wire Wire Line
	3250 7200 3250 7350
Wire Wire Line
	3250 7350 3900 7350
Connection ~ 3900 7350
Wire Wire Line
	2800 7000 3400 7000
Text Label 2800 7000 2    60   ~ 0
knvkl
Connection ~ 3250 7000
Text Label 1850 6400 0    60   ~ 0
bat
Wire Wire Line
	1850 6400 1850 6450
Connection ~ 1850 6450
Text Label 1800 5750 2    60   ~ 0
bat
$Comp
L GND #PWR012
U 1 1 5A4ED1D0
P 1650 6550
F 0 "#PWR012" H 1650 6300 50  0001 C CNN
F 1 "GND" H 1650 6400 50  0000 C CNN
F 2 "" H 1650 6550 50  0000 C CNN
F 3 "" H 1650 6550 50  0000 C CNN
	1    1650 6550
	1    0    0    -1  
$EndComp
$Comp
L R_Small R1
U 1 1 5A4EECCA
P 2000 5750
F 0 "R1" H 2030 5770 50  0000 L CNN
F 1 "10k" H 2030 5710 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 2000 5750 50  0001 C CNN
F 3 "" H 2000 5750 50  0001 C CNN
	1    2000 5750
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2100 5750 2200 5750
Wire Wire Line
	1800 5750 1900 5750
Text Notes 1100 7700 0    60   ~ 0
knvkl идет на мк на ADC \nпри нажатии кнопки будет 2.5в на мк, а при отпущеной будет макс из за подтяжки
Text Label 5250 3200 0    60   ~ 0
knvkl
$Comp
L R_Small R5
U 1 1 5A4EB6CB
P 10250 4850
F 0 "R5" H 10280 4870 50  0000 L CNN
F 1 "1k" H 10280 4810 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 10250 4850 50  0001 C CNN
F 3 "" H 10250 4850 50  0000 C CNN
	1    10250 4850
	0    1    1    0   
$EndComp
$Comp
L R_Small R6
U 1 1 5A4EB798
P 10250 4950
F 0 "R6" H 10280 4970 50  0000 L CNN
F 1 "1k" H 10280 4910 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 10250 4950 50  0001 C CNN
F 3 "" H 10250 4950 50  0000 C CNN
	1    10250 4950
	0    1    1    0   
$EndComp
$Comp
L R_Small R7
U 1 1 5A4EB888
P 10250 5050
F 0 "R7" H 10280 5070 50  0000 L CNN
F 1 "1k" H 10280 5010 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 10250 5050 50  0001 C CNN
F 3 "" H 10250 5050 50  0000 C CNN
	1    10250 5050
	0    1    1    0   
$EndComp
Wire Wire Line
	9850 4850 10150 4850
Wire Wire Line
	10150 4950 9850 4950
Wire Wire Line
	10150 5050 9850 5050
Wire Wire Line
	10350 4850 10650 4850
Wire Wire Line
	10350 4950 10650 4950
Wire Wire Line
	10350 5050 10650 5050
$Comp
L GND #PWR014
U 1 1 5AAF4771
P 4350 6550
F 0 "#PWR014" H 4350 6300 50  0001 C CNN
F 1 "GND" H 4350 6400 50  0000 C CNN
F 2 "" H 4350 6550 50  0000 C CNN
F 3 "" H 4350 6550 50  0000 C CNN
	1    4350 6550
	-1   0    0    1   
$EndComp
$Comp
L SW_Push SW1
U 1 1 5AAF496C
P 2400 5750
F 0 "SW1" H 2450 5850 50  0000 L CNN
F 1 "SW_Push" H 2400 5690 50  0000 C CNN
F 2 "Buttons_Switches_ThroughHole:SW_Tactile_SPST_Angled_PTS645Vx58-2LFS" H 2400 5950 50  0001 C CNN
F 3 "" H 2400 5950 50  0001 C CNN
	1    2400 5750
	1    0    0    -1  
$EndComp
Text Label 1850 4600 0    60   ~ 0
prg
$Comp
L Conn_01x01 J1
U 1 1 5ACD1C20
P 1650 4600
F 0 "J1" H 1650 4700 50  0000 C CNN
F 1 "Prg" H 1650 4500 50  0000 C CNN
F 2 "myowndevice:wirepad_mini" H 1650 4600 50  0001 C CNN
F 3 "" H 1650 4600 50  0001 C CNN
	1    1650 4600
	-1   0    0    1   
$EndComp
$Comp
L Conn_01x01 J5
U 1 1 5ACD219F
P 1650 4850
F 0 "J5" H 1650 4950 50  0000 C CNN
F 1 "GND" H 1650 4750 50  0000 C CNN
F 2 "myowndevice:wirepad_mini" H 1650 4850 50  0001 C CNN
F 3 "" H 1650 4850 50  0001 C CNN
	1    1650 4850
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR015
U 1 1 5ACD21E7
P 1850 4850
F 0 "#PWR015" H 1850 4600 50  0001 C CNN
F 1 "GND" H 1850 4700 50  0000 C CNN
F 2 "" H 1850 4850 50  0001 C CNN
F 3 "" H 1850 4850 50  0001 C CNN
	1    1850 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 1500 7850 1500
$Comp
L Conn_01x04 J2
U 1 1 5ACE086E
P 8800 1300
F 0 "J2" H 8800 1500 50  0000 C CNN
F 1 "Conn_01x04" H 8800 1000 50  0000 C CNN
F 2 "myowndevice:MLX90615" H 8800 1300 50  0001 C CNN
F 3 "" H 8800 1300 50  0001 C CNN
	1    8800 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 1600 8600 1600
Wire Wire Line
	8600 1600 8600 1500
Wire Wire Line
	8600 1300 8050 1300
Wire Wire Line
	8050 1300 8050 1500
$Comp
L R_Small R9
U 1 1 5ACE133C
P 5400 3100
F 0 "R9" H 5430 3120 50  0000 L CNN
F 1 "0" H 5430 3060 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 5400 3100 50  0001 C CNN
F 3 "" H 5400 3100 50  0000 C CNN
	1    5400 3100
	0    1    1    0   
$EndComp
Wire Wire Line
	5550 3100 5500 3100
Text Notes 7900 2200 0    60   ~ 0
НАДО датчик поменять местами ноги!
$EndSCHEMATC
