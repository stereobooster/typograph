# encoding: utf-8
# $KCODE = "utf-8" if defined?($KCODE)

require "typograph"
require "rspec"

OPT = {
  :ndash => '-'
}

describe '.process' do
  it 'Удаление лишних пробельных символов и табуляций' do
    text = "В  этом   тексте \t много пробелов."
    text_processed = 'В&nbsp;этом тексте много пробелов.'
    Typograph.process(text, OPT).should eq text_processed
  end

  # it 'Удаление повторяющихся слов' do
  #   text = 'При при проверке текста обнаружились обнаружились повторяющиеся слова слова. Слова убраны.'
  #   text_processed = 'При проверке текста обнаружились повторяющиеся слова. Слова убраны.'
  #   Typograph.process(text, OPT).should eq text_processed
  # end

  it 'Расстановка запятых перед а, но' do
    text = 'Мало написать а запятые кто за тебя расставит.'
    text_processed = 'Мало написать, а&nbsp;запятые кто за&nbsp;тебя расставит.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Отсутствие запятых у "а"" и "но" после тире' do
    text = 'Текст до тире – а теперь после'
    text_processed = 'Текст до&nbsp;тире&nbsp;— а&nbsp;теперь после'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка дефиса перед -то, -либо, -нибудь' do
    text = 'Кто то где то когда то как то что то чем то стукнул. И возможно чего нибудь бы получилось если б кто либо пришел.'
    text_processed = '<nobr>Кто-то</nobr> <nobr>где-то</nobr> <nobr>когда-то</nobr> <nobr>как-то</nobr> <nobr>что-то</nobr> <nobr>чем-то</nobr> стукнул. И&nbsp;возможно <nobr>чего-нибудь</nobr>&nbsp;бы получилось если&nbsp;б <nobr>кто-либо</nobr> пришел.'
    # Опять же что - то получилось, но как- то не так.
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка дефиса перед -ка, -де, -кась' do
    text = 'Возьми ка детка молока.  А коль увижу де, что казнь ему мала, повешу тут же всех судей вокруг стола. Поди кась так.'
    text_processed = '<nobr>Возьми-ка</nobr> детка молока. А&nbsp;коль <nobr>увижу-де</nobr>, что казнь ему мала, повешу тут&nbsp;же всех судей вокруг стола. <nobr>Поди-кась</nobr> так.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка дефиса после кое-, кой-' do
    text = 'Кое как дошли. Кой кого встретили. Кое от кого, кое на чем, кой у кого, кое с чьим.'
    text_processed = '<nobr>Кое-как</nobr> дошли. <nobr>Кой-кого</nobr> встретили. Кое от&nbsp;кого, кое на&nbsp;чем, кой у&nbsp;кого, кое с&nbsp;чьим.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка дефиса перед -таки' do
    text = 'Секретарь, хотя и чувствовал свое слабое недовольство, все таки радовался наличию таких старушек в активе района. Но хоть и велик был соблазн, я таки успел себя побороть.'
    text_processed = 'Секретарь, хотя и&nbsp;чувствовал свое слабое недовольство, <nobr>все-таки</nobr> радовался наличию таких старушек в&nbsp;активе района. Но&nbsp;хоть и&nbsp;велик был соблазн, я&nbsp;таки успел себя побороть.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка дефиса в предлогах из-за, из-под' do
    text = 'Из за леса величаво выплывало солнце. Из под развесистой сирени вдруг с лаем выскочила собака.'
    text_processed = '<nobr>Из-за</nobr> леса величаво выплывало солнце. <nobr>Из-под</nobr> развесистой сирени вдруг с&nbsp;лаем выскочила собака.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Удаление парных знаков препинания' do
    text = 'Правда!? Правда!!! Неправда??? Честно?? Честно!! Проехали.. Задумчиво...'
    text_processed = 'Правда?! Правда!!! Неправда??? Честно? Честно! Проехали. Задумчиво…'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Удаление пробелов перед знаками препинания' do
    text = 'Некоторые виды деревьев : ель ,сосна , берёза, дуб ; растут в наших лесах .'
    text_processed = 'Некоторые виды деревьев: ель, сосна, берёза, дуб; растут в&nbsp;наших лесах.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка пробелов после знака препинания' do
    text = 'Так бывает.И вот так...И ещё вот так!..Бывает же???Что поделать. Вывод:верен.'
    text_processed = 'Так бывает. И&nbsp;вот так… И&nbsp;ещё вот так!.. Бывает&nbsp;же??? Что поделать. Вывод: верен.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Удаление пробела перед символом процент' do
    text = '100 %'
    text_processed = '100%'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Удаление пробелов внутри скобок' do
    text = 'Текст( ( Внутри ) скобок ).'
    text_processed = 'Текст((Внутри) скобок).'
    Typograph.process(text, OPT).should eq text_processed
  end

  # it 'Расстановка пробела перед скобками' do
  #   text = 'Текст(Внутри скобок).'
  #   text_processed = 'Текст (Внутри скобок).'
  #   Typograph.process(text, OPT).should eq text_processed
  # end

  it 'Выделение прямой речи' do
    text = '- Я пошёл домой... - Может останешься? - Нет, ухожу.'
    text_processed = '—&nbsp;Я&nbsp;пошёл домой… —&nbsp;Может останешься? —&nbsp;Нет, ухожу.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Привязка союзов, предлогов' do
    text = 'Я бы в лётчики б пошёл, пусть меня научат.'
    text_processed = 'Я&nbsp;бы в&nbsp;лётчики&nbsp;б пошёл, пусть меня научат.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Замена x на символ × в размерных единицах' do
    text = '3х4, 3 х 6'
    text_processed = '3×4, 3×6'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Замена дробей 1/2, 1/4, 3/4 на соответствующие символы' do
    text = '1/2, 1/4, 3/4, 123/432'
    text_processed = '½, ¼, ¾, 123/432'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Замена (R) на символ зарегистрированной торговой марки' do
    text = '(r)'
    text_processed = '<sup><small>®</small></sup>'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Замена (c) на символ копирайт' do
    text = '(c) Eugene Spearance'
    text_processed = '© Eugene Spearance'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Замена (tm) на символ торговой марки' do
    text = 'ВасяПупкин(tm)'
    text_processed = 'ВасяПупкин™'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Тире в конце строки (стихотворная форма)' do
    text = %q{Раздобудь к утру ковёр -
    Шитый золотом узор!..
    Государственное дело, -
    Расшибись, а будь добёр!}
    text_processed = %q{Раздобудь к&nbsp;утру ковёр —<br />\nШитый золотом узор!..<br />\nГосударственное дело, —<br />\nРасшибись, а&nbsp;будь добёр!}
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка знака минус между числами' do
    text = '123-32'
    text_processed = '123–32'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка правильного апострофа в английских текстах' do
    text = "don't"
    text_processed = 'don’t'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Замена символа параграф с привязкой к числу' do
    text = '§32, §IV'
    text_processed = '&sect;&nbsp;32, &sect;&nbsp;IV'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Замена символа номер с привязкой к числу' do
    text = '№15Ф, №34/25'
    text_processed = '&#8470;&nbsp;15Ф, &#8470;&nbsp;34/25'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка правильных «тройных» кавычек' do
    text = 'Она добавила: "И цвет мой самый любимый - "эсмеральда"".'
    text_processed = 'Она добавила: «И&nbsp;цвет мой самый любимый&nbsp;— &bdquo;эсмеральда&ldquo;».'
    Typograph.process(text, OPT).should eq text_processed
  end

  # it 'Расстановка вложенных пар кавычек' do
  #   text = ''
  #   text_processed = ''
  #   Typograph.process(text, OPT).should eq text_processed
  # end

  it 'Расстановка пробелов и привязка в денежных сокращениях' do
    text = '10,34руб., 23тыс.долл., 64 млн.евро, 34.3€, 56$, 3,65уе'
    text_processed = '10,34&nbsp;руб., 23&nbsp;тыс.&nbsp;долл., 64&nbsp;млн.&nbsp;евро, 34.3&nbsp;&euro;, 56&nbsp;$, 3,65&nbsp;у.е.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Объединение сокращений и т.д., и т.п., в т.ч.' do
    text = 'Лес, газ, нефть и тд., и т.п.. Перины, подушки в тч. подушки-думки.'
    text_processed = 'Лес, газ, нефть <nobr>и т. д.</nobr>, <nobr>и т. п.</nobr> Перины, подушки <nobr>в т. ч.</nobr> <nobr>подушки-думки</nobr>.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка пробелов перед сокращениями см., им.' do
    text = 'Данные изложены в таблице см.цветной вкладыш. Дом им.Пушкина.'
    text_processed = 'Данные изложены в&nbsp;таблице см.&nbsp;цветной вкладыш. Дом им.&nbsp;Пушкина.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка пробелов перед сокращениями гл., стр., рис., илл.' do
    text = 'Инструкцию см. гл. 8, стр.34, рис.3 или илл.3.'
    text_processed = 'Инструкцию см.&nbsp;гл.&nbsp;8, стр.&nbsp;34, рис.&nbsp;3 или илл.&nbsp;3.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Объединение сокращений и др.' do
    text = 'Оля, Иван, Олег и др. ребята.'
    text_processed = 'Оля, Иван, Олег и&nbsp;др. ребята.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка пробелов в сокращениях г., ул., пер., д.' do
    text = 'г.Тюмень, ул.Ленина, пер. Ленина, бул. Ленина, д. 4'
    text_processed = 'г.&nbsp;Тюмень, ул.&nbsp;Ленина, пер.&nbsp;Ленина, бул.&nbsp;Ленина, д.&nbsp;4'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка пробелов перед сокращениями dpi, lpi' do
    text = 'Разрешение 300dpi (для офсета).'
    text_processed = 'Разрешение 300&nbsp;dpi (для офсета).'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Объединение сокращений P.S., P.P.S.' do
    text = 'P.S. привет всем. P.P.S. и мне тоже.'
    text_processed = '<nobr>P. S.</nobr> привет всем. <nobr>P. P. S.</nobr> и&nbsp;мне тоже.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Объединение в неразрывные конструкции слов с дефисом.' do
    text = 'Жёлто-оранжевый цвет. Ростов-на-Дону красивый город.'
    text_processed = '<nobr>Жёлто-оранжевый</nobr> цвет. <nobr>Ростов-на-Дону</nobr> красивый город.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Привязка сокращений форм собственности к названиям организаций' do
    text = 'ООО "Фирма "Терминал", НИИ "ОблСнабВротКомпот"'
    text_processed = '<nobr>ООО «Фирма «Терминал»</nobr>, <nobr>НИИ «ОблСнабВротКомпот»</nobr>'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Объединение в неразрывные конструкции номеров телефонов' do
    text = '+7 (3452) 55-66-77, 8 905 555-55-55'
    text_processed = '<nobr>+7 (3452) 55-66-77</nobr>, <nobr>8 905 555-55-55</nobr>'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Привязка сокращения ГОСТ к номеру' do
    text = 'Гост 5773-90 - российские стандартные форматы изданий'
    text_processed = '<nobr>ГОСТ 5773&ndash;90 —</nobr> российские стандартные форматы изданий'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Установка пробельных символов в сокращении вольт' do
    text = '~23,5в'
    text_processed = '<nobr>~23,5 В</nobr>'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Объединение триад чисел' do
    text = '123 456 789 руб. В стычке участвовало 3 200 человек.'
    text_processed = '123&nbsp;456&nbsp;789&nbsp;руб. В&nbsp;стычке участвовало 3&nbsp;200 человек.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Объединение IP-адресов' do
    text = 'Адрес localhost - 127.0.0.1'
    text_processed = 'Адрес localhost&nbsp;— <nobr>127.0.0.1</nobr>'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Установка тире и пробельных символов в периодах дат' do
    text = 'Это событие произошло между 1999-2001г.г., на стыке XX-XXIв.'
    text_processed = 'Это событие произошло между&nbsp;<nobr>1999—2001 гг.</nobr>, на&nbsp;стыке <nobr>XX—XXI вв.</nobr>'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Привязка года к дате' do
    text = 'Документ был подписан 17.02.1983г. И утратил свою силу 07.03.93 года.'
    text_processed = 'Документ был подписан <nobr>17.02.1983 г.</nobr> И&nbsp;утратил свою силу <nobr>07.03.93</nobr> года.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка тире и объединение в неразрывные периоды дней' do
    text = 'Собеседования состоятся 14-24 сентября, в актовом зале с 11:30-13:00.'
    text_processed = 'Собеседования состоятся <nobr>14—24 сентября</nobr>, в&nbsp;актовом зале с&nbsp;<nobr>11:30—13:00</nobr>.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Расстановка тире и объединение в неразрывные периоды месяцев' do
    text = 'Выставка пройдёт в апреле-мае этого года.'
    text_processed = 'Выставка пройдёт в&nbsp;<nobr>апреле-мае</nobr> этого года.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Привязка сокращений до н.э., н.э.' do
    text = 'IV в до н.э, в V-VIвв до нэ., третий в. н.э.'
    text_processed = 'IV в&nbsp;до&nbsp;н.э, в&nbsp;<nobr>V-VIвв</nobr> до&nbsp;нэ., третий&nbsp;в. н.э.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Привязка инициалов к фамилиям' do
    text = 'А.С.Пушкин, Пушкин А.С.'
    text_processed = 'А.С.&nbsp;Пушкин, Пушкин А.С.'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Замена символа градус, плюс-минус' do
    text = '+- 10, +/- 25'
    text_processed = '± 10, ± 25'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Замена символов и привязка сокращений в размерных величинах: м, см, м2…' do
    text = 'На лесопилку завезли 32 м3 леса, из которых 4м3 пустили под распил на 25мм доски, длинной по 6м.'
    text_processed = 'На&nbsp;лесопилку завезли 32&nbsp;м&sup3; леса, из&nbsp;которых 4&nbsp;м&sup3; пустили под распил на&nbsp;25&nbsp;мм доски, длинной по&nbsp;6&nbsp;м.'
    Typograph.process(text, OPT).should eq text_processed
  end

  # ...Когда В. И. Пупкин увидел в газете ( это была &quot;Сермяжная правда&quot; № 45) рубрику Weather Forecast(r), он не поверил своим глазам - температуру обещали +-451F.
  # Пушкин, оценивая всех своих предшественников, писал: &quot;... Некоторые оды Державина, несмотря на неправильность языка и неровность слога, исполнены порывами гения...&quot;

  it 'Повторное типографирование текста' do
    text = '<p><nobr>Coca-Cola</nobr><sup><small>&reg;</small></sup>&nbsp;— зарегистрированный товарный знак.</p>'
    text_processed = '<p><nobr>Coca-Cola</nobr><sup><small>®</small></sup>&nbsp;— зарегистрированный товарный знак.</p>'
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Обработка HTML' do
    text = '<!-- В тексте попался комментарий -->'
    text_processed = text.dup
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Обработка CSS' do
    text = %q{<style type="text/css">
      SPAN.nobr { white-space: nowrap }
    </style>}
    text_processed = text.dup
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Обработка JavaScript' do
    text = "<script type='text/javascript'>document.write('Этот текст не должен быть типографирован.')</script>"
    text_processed = text.dup
    Typograph.process(text, OPT).should eq text_processed
  end

  it 'Обработка тегов <pre>' do
    text = %q{<pre>   Я не хотел бы  
    чтобы этот текст 
    был   форматирован.</pre>}
    text_processed = text.dup
    Typograph.process(text, OPT).should eq text_processed
  end

  # it 'Выделение ссылок из текста' do
  #   text = 'В тексте встретилась ссылка: http://www.typograf.ru'
  #   text_processed = 'В&nbsp;тексте встретилась ссылка: <a href="http://www.typograf.ru">http://www.typograf.ru</a>'
  #   Typograph.process(text, OPT).should eq text_processed
  # end

  # it 'Выделение e-mail из текста' do
  #   text = 'В тексте встретился e-mail: mail@typograf.ru'
  #   text_processed = 'В&nbsp;тексте встретился <nobr>e-mail</nobr>: <a href="mailto:mail@typograf.ru">mail@typograf.ru</a>'
  #   Typograph.process(text, OPT).should eq text_processed
  # end

  # it 'Обработка списков' do
  #   text = ''
  #   # * Программное обеспечение
  #   # ** Операционные системы
  #   # +++ Windows XP
  #   # +++ Linux RedHat
  #   # +++ MacOS X
  #   # ** Текстовые радакторы
  #   # * Компьютеры
  #   text_processed = ''
  #   Typograph.process(text, OPT).should eq text_processed
  # end

  # it 'Выделение акронимов' do
  #   text = '<p>Все что вы хотели узнать о HTML.</p>'
  #   text_processed = '<p>Все что вы&nbsp;хотели узнать о&nbsp;<acronym title="HyperText Markup Language" lang="en">HTML</acronym>.</p>'
  #   Typograph.process(text, OPT).should eq text_processed
  # end
end
