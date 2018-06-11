uses graphABC,ABCObjects; // Подключаемые модули
var // Объявление переменных
i,xHead,yHead,z,appleX,appleY,l,a:integer;
Head:CircleABC;
restart:boolean;
snake:array[1..100] of CircleABC;
apple:circleABC;
score,over:textABC;
label start; // Часть функции перезапуска

procedure keyDown(key:integer); // Считывание нажатия клавиши
begin
  if(key = vk_Right) then z := 1;
  if(key = vk_Left) then z := 2;
  if(key = vk_Up) then z := 3;
  if(key = vk_Down) then z := 4;
  if(key = vk_escape) then halt;
  if(key = vk_R) then restart := true;
end;

 
begin
start:
  SetWindowIsFixedSize(true); // Установка фиксированного окна приложения
  SetBrushColor(cldimgray); // Серый цвет кисти
  FillRect(windowwidth,windowheight,0,0); // Заливка фона
  for i:=0 to 6 do // Создание горизонтальных линий
    begin
      line(0,i*80,windowWidth,i*80);
    end;
  
    for i:=0 to 8 do // Создание вертикальных линий
  begin
  line(i*80,0,i*80,windowHeight);
  end;
  
  xHead := 3*80 - 40; // Начальное положение змейки
  yHead := 2*80 - 40;
  
  appleX := 6*80 - 40; // Начальное положение яблока
  appleY := 3*80 -40;
  
  apple := CircleABC.Create(AppleX,AppleY,40,clcrimson); // Создание яблока
  
  Head  := CircleABC.Create(xHead,yHead,40,clorange); // Создание головы змейки
  
  score := textabc.Create(0,0,50,'0',clBlack); // Создание счетчика
  over := textabc.Create(0,0,50,'Press  "R"',clBlack); // Создание текста о проигрыше
  restart := false; // restart по умолчанию false
  
  l:=1; // Начальная длина змейки
  
  for i:=1 to l do // Создание остальных частей змейки
  begin
      snake[i]  := CircleABC.Create(xHead,yHead + 80*i,40,clforestgreen);
  end;
  
  while(true) do // Основной цикл
  begin
    
    onKeyDown := keyDown; // Часть функции считывания клавиш
    over.Visible := false; // Текст о проигрыше не виден по умолчанию
    
    if(z<>0) then // Перемещение каждой части за головой
    begin
    if (restart = true) then begin // Если нажата клавиша "R", то запускается цикл перезапуска
    for a:=0 to l do
          begin
          while (i < l+1) do begin // Охват всех частей змейки
          snake[i].Destroy; // Уничтожение тела змейки
          snake[1].Destroy; // Уничтожение первого элемента за головой змейки
          i:= i +1;
          end;
          head.Destroy; // Уничтожение головы змейки
          apple.Destroy; // Уничтожение яблока
          score.Destroy; // Уничтожение счетчика
          end;
          over.Visible := true; // Текст о проигрыше виден
          over.Text := 'Restarting...'; //Вывод надписи перезапуска
          over.MoveTo(150,150); // Перемещение текста в центр экрана
          sleep (1200); // Ожидание 1,2 секунды
          over.Destroy; // Уничтожение текста
    goto start; // Перемещние в начало (часть перезапуска)
    end;
    
      for i:=l downto 2 do 
        begin
          if((Head.Position) = (snake[i].Position)) then // Цикл проигрыша
            begin
           for a:=0 to 100 do
          begin
          snake[i].Destroy;
          snake[1].Destroy;
          head.Destroy;
          apple.Destroy;
          end;
            over.MoveTo(150,150);
            over.Visible := true;
            sleep (3000);
            score.Destroy;
            over.Destroy;
             end;
          if (score.Text = '20') then // Цикл победы при достижении 20 очков
          begin
          for a:=0 to 100 do
          begin
          snake[1].Destroy;
          snake[i].Destroy;
          head.Destroy;
          end;
            apple.Destroy;
             over.Visible := true;
             over.MoveTo(150,150);
             over.Text := 'YOU WON!';
          end;
          snake[i].MoveTo(snake[i-1].Position.X,snake[i-1].Position.Y); // Цикл перемещения частей змейки друг за другом
        end;
      
      snake[1].MoveTo(xHead-40,yHead-40);
      
    end;
    
    
    if(z = 1) then xHead := xHead + 80 // Непрерывное движение змейки
    else if (z = 2) then xHead := xHead - 80
    else if (z = 3) then yHead := yHead - 80
    else if (z = 4) then yHead := yHead + 80;
    
    if(xHead > windowWidth) then xHead := 40; // Змейка появляется на противоположной стороне при выходе за границу
    if(xHead < 0) then xHead := windowWidth - 40;
    if(yHead > windowWidth) then yHead := 40;
    if(yHead < 0) then yHead := windowWidth - 40;
    
    if((xHead = appleX) and (yHead = appleY)) then // Перемещение яблока, когда змейка кушает
    begin
      appleX := random(1,8)*80 - 40; // Перемещение яблока в случайную точку на поле
      appleY := random(1,6)*80 - 40;
      apple.MoveTo(appleX-40,appleY-40);
      score.Text := ((score.text).ToInteger + 1).ToString(); // Обновление счетчика при поедании яблока
      snake [l+1] := CircleABC.Create(xHead,yHead + 80*i,40,clforestgreen); // Создание новой части змейки
      l:= l + 1;
    end;
    
    head.MoveTo(xHead-40,yHead-40);
    sleep(200); // Скорость движения змейки
  end;
 end.
