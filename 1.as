.PROGRAM lesson2()
    ;
    ; ПОДГОТОВИТЕЛЬНЫЙ ЭТАП:
        ; установка скорости, 
        SPEED 100 MM/S ALWAYS
        ACCURACY 1
        ACCEL 70
        DECEL 70
        ; Открытие захвата 
        OPEN
        ; Перемеещение в домашнюю точку
        JMOVE #start
    ;
    ; ЗАХВАТ ПЕРВОГО БЛОКА
        ; Перемещение над первым блоком
        JAPPRO #pick_1, 50
        ; Перемещение на уровень первого блока
        LMOVE #pick_1
        ; Ожидание перемещения
        BREAK
        ; Закрытие захвата
        CLOSE
        ; Подождем пока захват закроется
        TWAIT 0.5
        ; Поднимим первый блок
        LAPPRO #pick_1,50
    ;
    ; ПЕРЕМЕЩЕНИЕ ПЕРВОГО БЛОКА
      ; Перемещение на расстояние от того места
      ; где лежал блок, то той точки, куда нужно его
      ; поставить.
      DRAW -450
      ; Перемещаемся ниже, чтобы поставить блок, 
      ; а не кидать его
      DRAW ,,-50
      ; Дождемся момента, когда манипулятор опуститься.
      BREAK
      ; Откроем захват
      OPEN
      ; Подождем пока он открывается
      TWAIT 0.5
      ; Поднимаемся над блоком линейно, чтоб его не задеть.
      DRAW ,,50
      ;
   ;
   ; ЗАХВАТ ВТОРОГА БЛОКА
      ; Перемещение над вторым блоком
      JAPPRO #pick_2, 50
      ; Перемещение на уровень второго блока
      LMOVE #pick_2
      ; Ожидание перемещения
      BREAK
      ; Закрытие захвата
      CLOSE
      ; Подождем пока захват закроется
      TWAIT 0.5
      ; Поднимим второй блок
      LAPPRO #pick_2,50
    ;
   ; ПЕРЕМЕЩЕНИЕ ПЕРВОГО БЛОКА
      ; Перемещение на расстояние от того места
      ; где лежал блок, то той точки, куда нужно его
      ; поставить.
      DRAW -450
      ; Перемещаемся ниже, чтобы поставить блок, 
      ; а не кидать его
      DRAW ,,-50
      ; Дождемся момента, когда манипулятор опуститься.
      BREAK
      ; Откроем захват
      OPEN
      ; Подождем пока он открывается
      TWAIT 0.5
      ; Поднимаемся над блоком линейно, чтоб его не задеть.
      DRAW ,,50
      ;
    ;
  ; ВЕРНЕМСЯ В ДОМАШНЕЕ ПОЛОЖЕНИЕ
    JMOVE #start
   ;
.END
.PROGRAM Comment___ () ; Comments for IDE. Do not use.
	; @@@ PROJECT @@@
	; @@@ HISTORY @@@
	; @@@ INSPECTION @@@
	; @@@ CONNECTION @@@
	; KROSET R01
	; 127.0.0.1
	; 9105
	; @@@ PROGRAM @@@
	; 0:lesson2:F
	; @@@ TRANS @@@
	; @@@ JOINTS @@@
	; @@@ REALS @@@
	; @@@ STRINGS @@@
	; @@@ INTEGER @@@
	; @@@ SIGNALS @@@
	; @@@ TOOLS @@@
	; @@@ BASE @@@
	; @@@ FRAME @@@
	; @@@ BOOL @@@
.END
.JOINTS
#start 0.000000 0.000000 -89.999626 0.000000 -89.999512 89.999687
#pick_1 22.790392 46.317657 -105.248283 0.000000 -28.433319 77.208801
#pick_2 18.579025 44.646679 -108.655884 0.000000 -26.696716 81.419975
.END
