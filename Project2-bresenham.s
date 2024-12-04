// Follows the integer arithmetic algorithm at
// https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
		.syntax     unified
		.cpu        cortex-m4
		.text

.equ DISPLAY,               0xD0000000
		.global		bresenham
		.thumb_func
		.align
bresenham:
push {R4-R11}
//x0,y0,x1,y1
SUB R4, R2,R0           //dx == R4
SUB R5,R3, R1           //dy == R5
MOV R6, R5
LSL R6, 1
SUB R6, R4              //D == R6

                        //y == R1
                        // x == R2
MOV R9, 240             // 240 == R9
LDR R10, =DISPLAY
LDR R11, =0xFF0000FF

SVC 0
loop:

MUL R7,R1,R9
ADD R7,R0
STR R11, [R10,R7, LSL 2]

CMP R6 , 0
ITTTT GT
ADDGT R1,1
MOVGT R7,R4
LSLGT R7, 1
SUBGT R6,R7
MOV R7, R5
LSL R7 ,1
ADD R6, R7
ADD R0,1
CMP R0,R2

blo loop

pop {R4-R11}

    bx lr
		.end
