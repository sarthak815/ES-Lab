
	AREA RESET,DATA,READONLY
	EXPORT __Vectors

__Vectors
	
	DCD 0x10001000
	DCD Reset_Handler
	ALIGN
	AREA mycode,CODE,READONLY
	ENTRY
	EXPORT Reset_Handler	

Reset_Handler
		
		LDR R0,=NUM
		LDM R0,{R1-R10}
		STMIA r13!, {r1-r10}
		MOV r0, r13 ;r0 stores the stack top
		MOV r2, #10 ;r2 stores number of elements in stack
		MOV r8,#0	;r8 is counter for outer loop
ol		
		CMP r8,r2
		BEQ exit
		
		MOV r1, r0	
		MOV r3, r0
		SUB r3, #4
		ADD r9,r8,#1
il		
		CMP r9,r2
		BEQ exin
		ADD r9,#1
		LDMDB r1,{r4}
		LDMDB r3!,{r5}
		CMP r5,r4
		BLT il
		STMDB r1,{r5}
		STM r3,{r4}
		B il
exin	SUB r0,#4
		ADD r8,#1
		B ol
		
exit	
		LDMDB r13!,{r1-r10}
STOP 	
	B STOP
NUM DCD 1,6,4,5,9,3,2,7,8,10
		AREA mydata,DATA,READWRITE

		END