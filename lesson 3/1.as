.AUXDATA
N_INT1    "wait_box  "
.END
.PROGRAM main ()
  ; Задаем начальные значения: скорость
  SPEED 100 MM/S ALWAYS
  ;
  ; Перемещаемся в начальное положение (для красоты)
  JMOVE #start
  ; Начинаем перемещение блоков
  WHILE TRUE DO
    ; Ждем сигнала для старта программы
    SWAIT wait_box
    
    ; Перемещаем каждый блок
    ; 0,0 - ближний к роботу справа от него
    ; 0,1 - дальний к роботу справа от него
    ; 1,0 - ближний к роботу слева от него
    ; 1,1 - дальний к роботу слева от него
    FOR .i = 0 TO 1
      FOR .j = 0  TO 1
        ; Рассчитываем позицию лежащего блока на 
        ; синей поверхности и поднимаем его
        POINT new_pick = SHIFT (pick_decard BY -.i* 50, .j *100)
        CALL pick
        
        ; Рассчитываем позицию куда поставить 
        ; и ставим блок.
        POINT place_point = SHIFT (new_pick BY -450)
        CALL place
      END
    END
    
    ; Делаем так, чтобы цикл не повторялся и ждал
    ; нового сигнала
    SIG -wait_box
    
    ; Перемещаемся в начальное положение (для красоты)
    JMOVE #start
  END
.END
.PROGRAM pick () ; 
  ; Подойдем в положение над блоком
  JAPPRO new_pick, 50
  ; Опустимся к точке
  LMOVE new_pick
  ; Подождем когда робот опустится
  BREAK
  ; Закроем захват
  CLOSE
  ; Подождем пока захват выполниться
  TWAIT 0.5
  ; Отойдем на высоту 100
  LDEPART 100
.END
.PROGRAM place()
  ; Подойдем в положение над тем местом
  ; куда требуется опустить
  JAPPRO place_point, 50
  ; Опустимся к точке
  LMOVE place_point
  ; Подождем когда робот опустится
  BREAK
  ; Откроем захват
  OPEN
  ; Подождем пока захват выполниться
  TWAIT 0.5
  ; Отойдем на высоту 100
  LDEPART 100
.END
.PROGRAM Comment___ () ; Comments for IDE. Do not use.
	; @@@ PROJECT @@@
	; 
	; @@@ HISTORY @@@
	; @@@ INSPECTION @@@
	; @@@ CONNECTION @@@
	; 
	; 
	; 
	; @@@ PROGRAM @@@
	; 0:main:F
	; 0:pick:F
	; .pick 
	; .pick_v 
	; .start_pick 
	; 0:place:F
	; @@@ TRANS @@@
	; @@@ JOINTS @@@
	; @@@ REALS @@@
	; @@@ STRINGS @@@
	; @@@ INTEGER @@@
	; @@@ SIGNALS @@@
	; wait_box 
	; @@@ TOOLS @@@
	; @@@ BASE @@@
	; @@@ FRAME @@@
	; @@@ BOOL @@@
.END
.TRANS
pick_decard 249.993881 500.003357 -277.994812 72.564850 179.998734 -17.437906
.END
.JOINTS
#start -0.001758 0.000000 -89.999626 -0.000580 -89.999519 89.999702
#pick 26.564415 38.598400 -121.154297 0.000580 -20.246058 63.432281
.END
.REALS
wait_box = 2001
.END
