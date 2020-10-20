.AUXDATA
N_INT1    "s_start_program  "
N_INT2    "s_take_block  "
N_INT3    "s_longitudal  "
N_INT4    "s_transverse  "
N_INT5    "s_is_run  "
.END
.INTER_PANEL_D
0,1,"   RUN","","","",10,15,4,2,2005,0
5,4,2,"1st layer","longitudal","transverse","",10,4,4,2003,2004,0
6,2,"","  START"," PROGRAM","",10,4,7,2001,0
16,9,1,3,7
21,8,"block_count","Number of","block",10,7,4,2,0
27,2,"","  NEXT","  BLOCK","",10,4,7,2002,0
.END
.INTER_PANEL_TITLE
"",0
"",0
"",0
"",0
"",0
"",0
"",0
"",0
.END
.INTER_PANEL_COLOR_D
182,3,224,244,28,159,252,255,251,255,0,31,2,241,52,219,
.END
.PROGRAM take_block()
  ; Перемещение над блоком
  LAPPRO take_point, (100 + d_z)
  LAPPRO take_point, 100
  SWAIT s_take_block
  SIG -s_take_block
  ; Перемещение на уровень первого блока
  LMOVE take_point
  ; Ожидание перемещения
  BREAK
  ; Закрытие захвата
  CLOSEI
  ; Подождем пока захват закроется
  TWAIT 1
  ; Поднимим первый блок
  LAPPRO take_point,(100 + d_z)
.END
.PROGRAM init_program()
  ; установка исходных данных 
  SPEED 100 MM/S ALWAYS
  ACCURACY 1.5 ALWAYS
  ACCEL 70 ALWAYS
  DECEL 70 ALWAYS
.END
.PROGRAM moving_near () ; 
  ; Задаем дистанцию до башни
  .distance_to_tower_y = -100 
  ; Перемещение на расстояние от того места
  ; где лежал блок, то той точки, куда нужно его
  ; поставить.
  DRAW 460, .distance_to_tower_y
  CALL put_block
.END
.PROGRAM main_long () ; 
  CALL init_program
  SIG s_is_run
  block_count = 0
  block_count2 = 0
  d_z = 0
  ;
  FOR i = 1 TO 1
    CALL take_block
    CALL moving_near
    block_count = block_count + 1
    ;
    CALL take_block
    CALL moving_far
    block_count = block_count + 1
    ;
    block_count2 = block_count2 + 1
    d_z = block_count2 * 25
    ;
    CALL take_block
    CALL mov_turn_near
    block_count = block_count + 1
    ;
    CALL take_block
    CALL mov_turn_far
    block_count = block_count + 1
    ;
    block_count2 = block_count2 + 1
    d_z = block_count2 * 25
  END
  JMOVE HOME
  SIG -s_is_run
.END
.PROGRAM mov_turn_near () ; 
; Задаем дистанцию до башни
  .distance_to_tower_y = -130
  ; Повернем брусок 6 ось на 45 градусов.
  DRIVE 6,90   
  ; Перемещение на расстояние от того места
  ; где лежал блок, то той точки, куда нужно его
  ; поставить.
  DRAW 492, .distance_to_tower_y
  CALL put_block
.END
.PROGRAM moving_far()
  ; Задаем дистанцию до башни
  .distance_to_tower_y = -100 
  ; Перемещение на расстояние от того места
  ; где лежал блок, то той точки, куда нужно его
  ; поставить.
  DRAW 525, .distance_to_tower_y
  CALL put_block
.END
.PROGRAM mov_turn_far()
; Задаем дистанцию до башни
  .distance_to_tower_y = -65
  ; Повернем брусок 6 ось на 45 градусов.
  DRIVE 6,90     
  ; Перемещение на расстояние от того места
  ; где лежал блок, то той точки, куда нужно его
  ; поставить.
  DRAW 492, .distance_to_tower_y
  CALL put_block
.END
.PROGRAM put_block()
  ; Перемещение на расстояние от того места
  ; где лежал блок, то той точки, куда нужно его
  ; поставить.
  DRAW ,,-100
  ; Дождемся момента, когда манипулятор опуститься.
  BREAK
  ; Откроем захват
  OPENI
  ; Подождем пока он открывается
  TWAIT 1
  ; Поднимаемся над блоком линейно, чтоб его не задеть.
  DRAW ,,100
.END
.PROGRAM main_trans()
  CALL init_program
  SIG s_is_run
  block_count = 0
  block_count2 = 0
  d_z = 0
  ;
  FOR i = 1 TO 2
     ;
    CALL take_block
    CALL mov_turn_near
    block_count = block_count + 1
    ;
    CALL take_block
    CALL mov_turn_far
    block_count = block_count + 1
    ;
    block_count2 = block_count2 + 1
    d_z = block_count2 * 25
    ;
    CALL take_block
    CALL moving_near
    block_count = block_count + 1
    ;
    CALL take_block
    CALL moving_far
    block_count = block_count + 1
    ;
    block_count2 = block_count2 + 1
    d_z = block_count2 * 25
  END
  JMOVE HOME
  SIG -s_is_run
.END
.PROGRAM DEMO.PC()
  IFPWPRINT 1 = ""
  WHILE TRUE DO
bedin_cycle:
    IF SIG (s_start_program) THEN
      SIG s_start_program
      IF NOT SWITCH (POWER) THEN
        IFPWPRINT 1 = "Please, turn the motor on"
        GOTO bedin_cycle
      END
      IF NOT SWITCH (REPEAT) THEN
        IFPWPRINT 1 = "Robot is not in repeat mode"
        GOTO bedin_cycle
      END
      ;IF NOT SWITCH (TEACH_LOCK) THEN
      ; IFPWPRINT 1 = "Teach lock is on!"
      ;GOTO bedin_cycle
      ;END
      IF SWITCH (CS) THEN
        IFPWPRINT 1 = "Another program is running"
        GOTO bedin_cycle
      END
      ;
      IF SIG (s_longitudal) THEN
        MC EXECUTE main_long
      END
      ;
      IF SIG (s_transverse) THEN
        MC EXECUTE main_trans
      END
      ;
      TWAIT 3
    END
  END
.END
.PROGRAM Comment___ () ; Comments for IDE. Do not use.
	; @@@ PROJECT @@@
	; 
	; @@@ HISTORY @@@
	; @@@ INSPECTION @@@
	; @@@ CONNECTION @@@
	; KROSET R01
	; 127.0.0.1
	; 9105
	; @@@ PROGRAM @@@
	; 0:take_block:F
	; 0:init_program:F
	; 0:moving_near:F
	; .distance_to_tower_y 
	; 0:main_long:F
	; 0:mov_turn_near:F
	; .distance_to_tower_y 
	; 0:moving_far:F
	; .distance_to_tower_y 
	; 0:mov_turn_far:F
	; .distance_to_tower_y 
	; 0:put_block:F
	; 0:main_trans:F
	; 0:DEMO.PC:B
	; @@@ TRANS @@@
	; @@@ JOINTS @@@
	; @@@ REALS @@@
	; @@@ STRINGS @@@
	; @@@ INTEGER @@@
	; @@@ SIGNALS @@@
	; s_start_program 
	; s_take_block 
	; s_longitudal 
	; s_transverse 
	; s_is_run 
	; @@@ TOOLS @@@
	; @@@ BASE @@@
	; @@@ FRAME @@@
	; @@@ BOOL @@@
.END
.TRANS
home 0.000000 515.001892 242.000031 90.000000 179.999512 -179.999680
take_point -319.998993 650.006104 -269.995026 116.219986 179.999268 -153.779510
.END
.REALS
block_count = 0
s_start_program = 2001
s_take_block = 2002
s_longitudal = 2003
s_transverse = 2004
s_is_run = 2005
.END
