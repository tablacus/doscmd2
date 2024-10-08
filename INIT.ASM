;
;	Tablacus DOS cmd 2
;
	LD	C,06FH		;(BDOS)MSX-DOS のバージョン番号の獲得
	CALL	BDOS
	LD	A,B
	OR	A
	RET	Z		;DOS2専用

	LD	A,(HOKVLD)
	AND	1
	RET	Z		;拡張BIOSが存在しない

	XOR	A
	LD	DE,00401H	;D=デバイスID
	CALL	EXTBIO
	OR	A
	RET	Z		;マッパーサポートルーチンが存在しない
	LD	(MMAP_TABLE_PTR),HL

	LD	DE,00402H	;D=デバイスID
	CALL	EXTBIO

	LD	DE,MAPPER_JUMP_TABLE
	LD	BC,16*3*256+1
	EX	DE,HL
SET_MJT:
	LD	A,(DE)
	INC	DE
	CP	(HL)
	JR	Z,SET_MJT1
	LD	(HL),A
	LD	C,0
SET_MJT1:
	INC	HL
	DJNZ	SET_MJT

	DEC	C		;マッパーサポートルーチンがすでにインストールされている
	RET	Z

	LD	DE,RAM_TABLE
	LD	H,0
SET_TABLE:			;現在のRAMの状況をRAM_TABLEに取得
	CALL	MAPPER_GET_PH
	LD	(DE),A
	INC	DE
	ADD	HL,BC
	LD	A,H
	ADD	A,040H
	LD	H,A
	JR	NC,SET_TABLE
GET_MAPPER_RAM:			;新たに64KB RAMを取得する
	LD	A,1			;システムセグメントとして取得する
	LD	B,0			;プライマリーマッパーから確保する
	CALL	MAPPER_ALL_SEG
	RET	C			;CF=1 : 空きセグメントが無い
	LD	(DE),A
	INC	DE
	LD	A,H
	ADD	A,040H
	LD	H,A
	JR	NC,GET_MAPPER_RAM
				;DOSのページ 0を初期化
	DI
	LD	H,040H
	LD	A,(RAMAD2)
	CALL	_ENASLT

	LD	H,080H
	LD	A,(DOS_RAM_0)
	CALL	MAPPER_PUT_PH

	LD	HL,04000H
	LD	A,(BASIC_RAM_0)
	CALL	MAPPER_PUT_PH

	LD	DE,08000H
	LD	BC,00100H
	LDIR

	DB	03EH	;LD A,?
	POP	AF
	LD	(H_CMD),A

	LD	A,0C3H		;JP

	LD	HL,CPM_WBOOT
	LD	(08000H),A
	LD	(08001H),HL

	LD	HL,BDOS0
	LD	(08005H),A
	LD	(08006H),HL

	LD	HL,BDOS1
	LD	(BDOS0),A
	LD	(BDOS0+1),HL

	LD	(H_CMD+1),A
	LD	HL,_CMD
	LD	(H_CMD+2),HL

	LD	H,040H
	LD	A,(BASIC_RAM_1)
	CALL	MAPPER_PUT_PH

	LD	H,080H
	LD	A,(BASIC_RAM_2)
	CALL	MAPPER_PUT_PH

	LD	H,040H
	LD	A,(EXPTBL)
	CALL	_ENASLT
	EI
	LD	DE,TITLE
	LD	C,9
	JP	BDOS

; Version
TITLE:
	DB	"Tablacus DOS cmd 2 v0.10"
	DB	00DH,00AH,'$'
