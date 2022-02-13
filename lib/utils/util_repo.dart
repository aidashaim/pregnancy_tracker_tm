import 'package:pregnancy_tracker_tm/models/name_model.dart';

class UtilRepo {
  UtilRepo._();

  static int pregnancyDuration = 294;

  static String shareUrlAndroid ='https://play.google.com/store/apps/details?id=com.pregnancytracker.tm';
  static String shareUrlIOS ='';

  static List<String> cribListItems = [
    'Детская кроватка',
    'Твердый матрас',
    'Наматрасник',
    'Легкое и теплое одеяло',
    'Набор простыней',
    'Пододеяльник',
    'Ночник',
    'Мобиль',
    'Радионяня',
    'Термометр в комнату',
    'Кокон для сна',
    'Увлажнитель воздуха',
  ];
  static List<String> strollerListItems = [
    'Коляска-люлька',
    'Дождевик на коляску',
    'Автокресло',
    'Утепленный конверт',
    'Эргорюкзак / Слинг',
    'Сетка от комаров на коляску',
  ];
  static List<String> bathingListItems = [
    'Надувной воротник',
    'Несколько полотенец',
    'Мыло, шампунь, гель для мытья',
    'Масло для массажа',
    'Детский крем',
    'Термометр для воды',
    'Ватные диски и тампомны',
    'Маникюрные ножницы',
  ];
  static List<String> feedingListItems = [
    'Несколько бутылочек разного размера',
    'Соски-пустышки',
    'Соски для бутылочек',
    'Прибор для стерилизации',
    'Детское средство для посуды',
    'Молокоотсос',
    'Бюстгальтер для кормления',
    'Прокладки для груди',
  ];
  static List<String> clothesListItems = [
    '4-5 комбинезонов для дома',
    '2-3 боди с короткими и длинными рукавами',
    '4-5 пар детских носочков',
    'Шерстяной или флисовой комбинезон',
    '1-2 теплых уличных шапочек',
    '1-2 пар царапок',
    '4-5 слюнявчиков или нагрудничков',
  ];
  static List<String> diapersListItems = [
    'Подгузники',
    'Пеленальный столик/комод',
    'Влажные салфетки',
    'Простые салфетки',
    'Присыпка или Крем',
    'Пеленки одноразовые',
    'Закрывающиеся мусорное ведро',
  ];
  static List<String> aidListItems = [
    'Жаропонижающие средства',
    'Средство от коликов',
    'Свечи слабительные',
    'Средства от аллергии',
    'Перекись водорода',
    'Йод',
    'Стерильная вата',
    'Ватные палочки',
    'Ромашка для купания малыша',
    'Термометр',
    'Аспиратор для сморкания',
    'Пипетка',
    'Шприц',
    'Марля',
  ];

  static List<String> hospitalBagItems = [
    'Документы',
    'халат из натуральной ткани',
    'ночная сорочка',
    'нижнее белье, носки',
    'послеродовый бандаж',
    'бюстгальтер для грудного вскармливания',
    'прорезиненные тапочки',
    'гигиенические прокладки для рожениц и сетчатые штаны для их фиксации',
    'гигиенические накладки на грудь',
    'одноразовые накладки на унитаз',
    'впитывающие пеленки, размером 60х60 см, не меньше',
    'средства гигиены: шампунь, мыло, мочалка, зубная щетка и паста',
    'полотенце',
    'туалетная бумага',
    'влажные и сухие одноразовые полотенца или салфетки',
    'расческа, резинка для волос',
    'средства для увлажнения кожи: крем или лосьон',
    'глицериновые свечи на случай запора',
    'чашка и ложка',
    'зарядка для телефона',
    'чепчик, боди, носки ',
    'пеленки',
    'полотенце',
    'упаковка подгузников',
    'присыпка',
    'детское мыло',
    'ножницы для подстригания ногтей',
    'бутылочка и искусственное питание для кормления на случай отсутствия грудного молока',
    'соска'
  ];

  static List<NameModel> names = [
    NameModel(id: 1, sex: false, name: 'Августин', meaning: 'величественный, священный'),
    NameModel(id: 2, sex: false, name: 'Аверкий', meaning: 'обращающий в бегство, непобедимый, Удерживающий'),
    NameModel(id: 3, sex: false, name: 'Агап', meaning: 'любимый'),
    NameModel(id: 4, sex: false, name: 'Адам', meaning: 'человек, сын Божий'),
    NameModel(id: 5, sex: false, name: 'Адриан', meaning: 'житель Адрии'),
    NameModel(id: 6, sex: false, name: 'Акакий', meaning: 'не делающий зла, незлобный'),
    NameModel(id: 7, sex: false, name: 'Александр', meaning: 'защитник, оберегающий муж, мужчина, человек'),
    NameModel(id: 8, sex: false, name: 'Алексей', meaning: 'защитник, оберегающий муж'),
    NameModel(id: 9, sex: false, name: 'Альфред', meaning: 'ум, мудрость'),
    NameModel(id: 10, sex: false, name: 'Ананий', meaning: 'отмеченный милостью Божьей'),
    NameModel(id: 11, sex: false, name: 'Анастасий', meaning: 'воскресший'),
    NameModel(id: 17, sex: false, name: 'Анатолий', meaning: 'восток, восточный, восходящий'),
    NameModel(id: 19, sex: false, name: 'Андрей', meaning: 'муж, мужчина, мужественный, храбрый'),
    NameModel(id: 20, sex: false, name: 'Антон', meaning: 'вступающий в бой, противник, состязающийся'),
    NameModel(id: 21, sex: false, name: 'Аполлон', meaning: 'бог солнца, покровитель искусств'),
    NameModel(id: 22, sex: false, name: 'Аристарх', meaning: 'лучший вождь'),
    NameModel(id: 23, sex: false, name: 'Аркадий', meaning: 'жителя Аркадии'),
    NameModel(id: 24, sex: false, name: 'Арнольд', meaning: 'царящий орел'),
    NameModel(id: 25, sex: false, name: 'Арсений', meaning: 'мужчина, мужской, мужественный'),
    NameModel(id: 26, sex: false, name: 'Артамон', meaning: 'парус'),
    NameModel(id: 27, sex: false, name: 'Артем', meaning: 'невредимый, здравый, безупречного здоровья'),
    NameModel(id: 28, sex: false, name: 'Артур', meaning: 'медведь'),
    NameModel(id: 29, sex: false, name: 'Архипп', meaning: 'старший всадник'),
    NameModel(id: 30, sex: false, name: 'Афанасий', meaning: 'бессмертный'),
    NameModel(id: 31, sex: false, name: 'Борис', meaning: 'борьба за славу, борец за славу, борющийся за славу'),
    NameModel(
        id: 32,
        sex: false,
        name: 'Вадим',
        meaning: 'сеять смуту, спорить, обвинять, клеветать, спорщик, раздорник, доказывающий'),
    NameModel(id: 33, sex: false, name: 'Валентин', meaning: 'здоровый'),
    NameModel(id: 34, sex: false, name: 'Валерий', meaning: 'быть здоровым, будь здоров, быть сильным'),
    NameModel(id: 35, sex: false, name: 'Варфоломей', meaning: 'сын вспаханной земли, сын полей (арамейское)'),
    NameModel(id: 36, sex: false, name: 'Василий', meaning: 'царственный'),
    NameModel(id: 37, sex: false, name: 'Вениамин', meaning: 'любимый сын'),
    NameModel(id: 38, sex: false, name: 'Виктор', meaning: 'победа'),
    NameModel(id: 39, sex: false, name: 'Виталий', meaning: 'жизненный'),
    NameModel(id: 40, sex: false, name: 'Владимир', meaning: 'владеющий миром'),
    NameModel(id: 41, sex: false, name: 'Владислав', meaning: 'владеющий славой'),
    NameModel(id: 42, sex: false, name: 'Всеволод', meaning: 'всем владеющий'),
    NameModel(id: 43, sex: false, name: 'Вячеслав', meaning: 'достославный, наиславнейший'),
    NameModel(id: 44, sex: false, name: 'Гавриил', meaning: 'божественный воин'),
    NameModel(id: 45, sex: false, name: 'Геннадий', meaning: 'благородный, родовитый, благородного происхождения'),
    NameModel(id: 46, sex: false, name: 'Георгий', meaning: 'земледелец, землепашец'),
    NameModel(id: 47, sex: false, name: 'Герасим', meaning: 'почтенный'),
    NameModel(id: 48, sex: false, name: 'Герман', meaning: 'единородный, единокровный'),
    NameModel(id: 49, sex: false, name: 'Глеб', meaning: 'наследник, наследник бога'),
    NameModel(id: 50, sex: false, name: 'Давид', meaning: 'любимый'),
    NameModel(id: 51, sex: false, name: 'Даниил', meaning: 'мой судья, эль'),
    NameModel(id: 52, sex: false, name: 'Дементий', meaning: 'укрощающий'),
    NameModel(id: 53, sex: false, name: 'Демид', meaning: 'совет Зевса'),
    NameModel(id: 54, sex: false, name: 'Демьян', meaning: 'покоритель, усмиритель'),
    NameModel(id: 55, sex: false, name: 'Денис', meaning: 'посвященный Дионису, богу веселья'),
    NameModel(id: 56, sex: false, name: 'Дмитрий', meaning: 'относящийся к Деметре'),
    NameModel(id: 57, sex: false, name: 'Дорофей', meaning: 'дар богов'),
    NameModel(id: 58, sex: false, name: 'Евгений', meaning: 'благородный'),
    NameModel(id: 59, sex: false, name: 'Евграф', meaning: 'хорошо пишущий'),
    NameModel(id: 60, sex: false, name: 'Егор', meaning: 'покровитель земледелия'),
    NameModel(id: 61, sex: false, name: 'Елисей', meaning: 'спасение'),
    NameModel(id: 62, sex: false, name: 'Емельян', meaning: 'льстивый'),
    NameModel(id: 63, sex: false, name: 'Епифан', meaning: 'знатный, славный'),
    NameModel(id: 64, sex: false, name: 'Ефим', meaning: 'знатный, славный'),
    NameModel(id: 65, sex: false, name: 'Захар', meaning: 'память Господня'),
    NameModel(
        id: 66,
        sex: false,
        name: 'Иван',
        meaning: 'Яхве (Бог) смилостивился, Яхве (Бог) помиловал, дар Бога, благодать Божья'),
    NameModel(id: 67, sex: false, name: 'Игорь', meaning: 'воинственный'),
    NameModel(id: 68, sex: false, name: 'Илья', meaning: 'мой Бог - Господь, крепость господня, верующий, благоверный'),
    NameModel(id: 69, sex: false, name: 'Ипатий', meaning: 'высочайший'),
    NameModel(id: 70, sex: false, name: 'Ипполит', meaning: 'распрягающий коней'),
    NameModel(id: 71, sex: false, name: 'Исмаил', meaning: 'Бог услышит'),
    NameModel(id: 72, sex: false, name: 'Киприан', meaning: 'Житель острова Кипр'),
    NameModel(id: 73, sex: false, name: 'Кир', meaning: 'солнце, солнечный'),
    NameModel(id: 74, sex: false, name: 'Кирилл', meaning: 'маленький господин, барчук'),
    NameModel(id: 75, sex: false, name: 'Кондрат', meaning: 'квадрат'),
    NameModel(id: 76, sex: false, name: 'Кондратий', meaning: 'воин, несущий копье'),
    NameModel(id: 77, sex: false, name: 'Константин', meaning: 'стойкий, постоянный, твердый'),
    NameModel(id: 78, sex: false, name: 'Лавр', meaning: 'от названия дерева'),
    NameModel(id: 79, sex: false, name: 'Лаврентий', meaning: 'увенчанный лаврами'),
    NameModel(id: 80, sex: false, name: 'Лев', meaning: 'царь зверей'),
    NameModel(id: 81, sex: false, name: 'Леонид', meaning: 'подобный льву'),
    NameModel(id: 82, sex: false, name: 'Лукьян', meaning: 'светлый'),
    NameModel(id: 83, sex: false, name: 'Мавр', meaning: 'затмевающий, смуглый, мрачный, мавр'),
    NameModel(id: 84, sex: false, name: 'Маврикий', meaning: 'темный'),
    NameModel(id: 85, sex: false, name: 'Максим', meaning: 'величайший, самый большой, превеликий'),
    NameModel(id: 86, sex: false, name: 'Марк', meaning: 'молот'),
    NameModel(id: 87, sex: false, name: 'Матвей', meaning: 'дарованный Богом, дар Яхве Бога, Божий человек'),
    NameModel(id: 88, sex: false, name: 'Мирон', meaning: 'благовонный'),
    NameModel(id: 89, sex: false, name: 'Митрофан', meaning: 'имеющий славную мать'),
    NameModel(id: 90, sex: false, name: 'Михаил', meaning: 'как Бог'),
    NameModel(id: 91, sex: false, name: 'Михей', meaning: 'подобный Богу'),
    NameModel(id: 92, sex: false, name: 'Модест', meaning: 'скромный'),
    NameModel(id: 93, sex: false, name: 'Моисей', meaning: 'взятый от бога'),
    NameModel(id: 94, sex: false, name: 'Мстислав', meaning: 'славный мститель'),
    NameModel(id: 95, sex: false, name: 'Назар', meaning: 'посвятил себя богу'),
    NameModel(id: 96, sex: false, name: 'Наум', meaning: 'утешающий'),
    NameModel(id: 97, sex: false, name: 'Никита', meaning: 'победитель, победоносный, побеждать'),
    NameModel(id: 98, sex: false, name: 'Никодим', meaning: 'одержавший победу над народом'),
    NameModel(id: 99, sex: false, name: 'Николай', meaning: 'победитель народов'),
    NameModel(id: 100, sex: false, name: 'Олег', meaning: 'священный, светлый'),
    NameModel(id: 101, sex: false, name: 'Павел', meaning: 'малыш, малый, маленький'),
    NameModel(id: 102, sex: false, name: 'Пётр', meaning: 'камень, скала, утес, каменная глыба'),
    NameModel(id: 103, sex: false, name: 'Платон', meaning: 'широкоплечий, плечистый, широкий, полный, мощный'),
    NameModel(id: 104, sex: false, name: 'Роман', meaning: 'римлянин, римский'),
    NameModel(id: 105, sex: false, name: 'Ростислав', meaning: 'растущая слава'),
    NameModel(id: 106, sex: false, name: 'Руслан', meaning: 'лев'),
    NameModel(id: 107, sex: false, name: 'Савва', meaning: 'неволя, плен, вино, старец'),
    NameModel(id: 108, sex: false, name: 'Святослав', meaning: 'святая слава'),
    NameModel(id: 109, sex: false, name: 'Севастьян', meaning: 'высокочтимый'),
    NameModel(id: 110, sex: false, name: 'Семён', meaning: 'слышащий'),
    NameModel(id: 111, sex: false, name: 'Сергей', meaning: 'высокий, высокочтимый, почтенный, ясный'),
    NameModel(id: 112, sex: false, name: 'Сильвестр', meaning: 'житель леса'),
    NameModel(id: 113, sex: false, name: 'Симон', meaning: 'услышанный богом'),
    NameModel(id: 114, sex: false, name: 'Сократ', meaning: 'сохраняющий власть'),
    NameModel(id: 115, sex: false, name: 'Соломон', meaning: 'мирный'),
    NameModel(id: 116, sex: false, name: 'Станислав', meaning: 'славнейший, стать славным'),
    NameModel(id: 117, sex: false, name: 'Степан', meaning: 'венок, венец, корона, кольцо'),
    NameModel(id: 118, sex: false, name: 'Стефан', meaning: 'кольцо, венок, венец'),
    NameModel(id: 119, sex: false, name: 'Тарас', meaning: 'возбуждать'),
    NameModel(id: 120, sex: false, name: 'Тимофей', meaning: 'почитающий Бога'),
    NameModel(id: 121, sex: false, name: 'Тиранн', meaning: 'вспыльчивый'),
    NameModel(id: 122, sex: false, name: 'Фёдор', meaning: 'дарованный Богом, Божий дар'),
    NameModel(id: 123, sex: false, name: 'Федот', meaning: 'данный богами, долгожданный, милый'),
    NameModel(id: 124, sex: false, name: 'Федр', meaning: 'дарованный Богом, Божий дар'),
    NameModel(id: 125, sex: false, name: 'Феликс', meaning: 'счастливый'),
    NameModel(id: 126, sex: false, name: 'Феофан', meaning: 'бога являющий'),
    NameModel(id: 127, sex: false, name: 'Филимон', meaning: 'любимый'),
    NameModel(id: 128, sex: false, name: 'Филипп', meaning: 'любитель коней'),
    NameModel(id: 129, sex: false, name: 'Флавий', meaning: 'из рода Флавиев'),
    NameModel(id: 130, sex: false, name: 'Флорентий', meaning: 'расцветающий'),
    NameModel(id: 131, sex: false, name: 'Фома', meaning: 'близнец'),
    NameModel(id: 132, sex: false, name: 'Харитон', meaning: 'благосклонность'),
    NameModel(id: 133, sex: false, name: 'Эдуард', meaning: 'заботящийся о достатке, страж богатства, счастья'),
    NameModel(id: 134, sex: false, name: 'Элладий', meaning: 'утренняя заря'),
    NameModel(id: 135, sex: false, name: 'Эраст', meaning: 'милый, любимый'),
    NameModel(id: 136, sex: false, name: 'Ювеналий', meaning: 'юношеский'),
    NameModel(id: 137, sex: false, name: 'Юлиан', meaning: 'из рода Юлиев'),
    NameModel(id: 138, sex: false, name: 'Юлий', meaning: 'кудрявый, пушистый'),
    NameModel(id: 139, sex: false, name: 'Юрий', meaning: 'емледелец, землетруженик, земле-работчик'),
    NameModel(id: 140, sex: false, name: 'Яков', meaning: 'пятка'),
    NameModel(id: 141, sex: false, name: 'Ярополк', meaning: 'яростный боец'),
    NameModel(id: 143, sex: true, name: 'Юлия', meaning: 'кудрявая, июльская, из рода Юлиев'),
    NameModel(id: 144, sex: true, name: 'Нина', meaning: 'царица'),
    NameModel(id: 145, sex: true, name: 'Александра', meaning: 'победительница'),
    NameModel(id: 146, sex: true, name: 'Августа', meaning: 'латинское, величественная'),
    NameModel(id: 147, sex: true, name: 'Августина', meaning: 'величественная, величайшая'),
    NameModel(id: 148, sex: true, name: 'Агапия', meaning: 'любимая'),
    NameModel(id: 149, sex: true, name: 'Агафья', meaning: 'хорошая, мудрая'),
    NameModel(id: 150, sex: true, name: 'Агния', meaning: 'непорочная, невинная '),
    NameModel(id: 151, sex: true, name: 'Агриппина', meaning: 'горестная'),
    NameModel(id: 152, sex: true, name: 'Аделина', meaning: 'важная, благородная'),
    NameModel(id: 153, sex: true, name: 'Аза', meaning: 'сильная, крепкая'),
    NameModel(id: 154, sex: true, name: 'Алевтина', meaning: 'сильная, крепкая, здоровая'),
    NameModel(id: 155, sex: true, name: 'Алексина', meaning: 'защитница'),
    NameModel(id: 156, sex: true, name: 'Алена', meaning: 'светоч, факел, сияющая, солнечная'),
    NameModel(id: 157, sex: true, name: 'Алина', meaning: 'крепкая, здоровая'),
    NameModel(id: 158, sex: true, name: 'Алиса', meaning: 'истина, крылатая, из благородного рода '),
    NameModel(id: 159, sex: true, name: 'Алла', meaning: 'богиня'),
    NameModel(id: 160, sex: true, name: 'Альбина', meaning: 'чистая, белая'),
    NameModel(
        id: 161,
        sex: true,
        name: 'Анастасия',
        meaning: 'возвращение к жизни, воскресение, воскресшая, возрожденная, бессмертная'),
    NameModel(id: 162, sex: true, name: 'Ангелина', meaning: 'вестник, посланец, ангел'),
    NameModel(id: 163, sex: true, name: 'Анна', meaning: 'благодать, милость божья, миловидная, симпатичная '),
    NameModel(
        id: 164,
        sex: true,
        name: 'Антонина',
        meaning: 'вступающая в бой, состязающаяся в силе, противостоящая, противница'),
    NameModel(id: 165, sex: true, name: 'Анфиса', meaning: 'цветущая'),
    NameModel(
        id: 166,
        sex: true,
        name: 'Аполлинария',
        meaning: 'Аполлонова, принадлежащая Аполлону, посвященная Аполлону, освобожденная, городская'),
    NameModel(id: 167, sex: true, name: 'Арина', meaning: 'мир, покой'),
    NameModel(id: 168, sex: true, name: 'Валентина', meaning: 'сильная, здоровая'),
    NameModel(id: 169, sex: true, name: 'Валерия', meaning: 'сильная, крепкая'),
    NameModel(id: 170, sex: true, name: 'Варвара', meaning: 'грубая, жесткая'),
    NameModel(id: 171, sex: true, name: 'Василиса', meaning: 'царица, царская, царственная'),
    NameModel(id: 172, sex: true, name: 'Вера', meaning: 'вера, служение Богу'),
    NameModel(id: 173, sex: true, name: 'Вероника', meaning: 'несущая победу, победа, подлинная, истинная'),
    NameModel(id: 174, sex: true, name: 'Виктория', meaning: 'победа, победительница'),
    NameModel(
        id: 175,
        sex: true,
        name: 'Галина',
        meaning: 'спокойная, безмятежная, ясность, тишина, гладь моря, кротость, штиль на море, тихая погода'),
    NameModel(id: 176, sex: true, name: 'Дарья', meaning: 'владетельница блага, обладающая, владеющая добром'),
    NameModel(id: 177, sex: true, name: 'Диана', meaning: 'посланница здоровья и благодеяния, божественная'),
    NameModel(id: 178, sex: true, name: 'Динара', meaning: 'золотая или серебряная монета, ценная, дорогая'),
    NameModel(
        id: 179,
        sex: true,
        name: 'Доминика',
        meaning: 'Божий день, принадлежащая Богу, рожденная в воскресенье, госпожа'),
    NameModel(id: 180, sex: true, name: 'Дорофея', meaning: 'дар богов, дарованная Богом'),
    NameModel(id: 181, sex: true, name: 'Ева', meaning: 'жить, дышать, дарующая жизнь, приносящая жизнь'),
    NameModel(id: 182, sex: true, name: 'Евгения', meaning: 'благородная'),
    NameModel(id: 183, sex: true, name: 'Евдокия', meaning: 'благоволение, благославная'),
    NameModel(id: 184, sex: true, name: 'Евдоксия', meaning: 'добрая слава, благовоние'),
    NameModel(id: 185, sex: true, name: 'Евлампия', meaning: 'Благосветная, светящая'),
    NameModel(id: 186, sex: true, name: 'Екатерина', meaning: 'вечно чистая, непорочная'),
    NameModel(
        id: 187,
        sex: true,
        name: 'Елена',
        meaning: 'светлая, факел, огонь, избранная, сверкающая, блестящая, солнечная  '),
    NameModel(id: 188, sex: true, name: 'Елизавета', meaning: 'Божья помощь, почитающая Бога, клятва Божья'),
    NameModel(id: 189, sex: true, name: 'Захария', meaning: 'память Господня, Господь вспомнил'),
    NameModel(
        id: 190,
        sex: true,
        name: 'Зина',
        meaning: 'принадлежащая Зевсу, из рода Зевса, рожденная Зевсом, божественная дочь'),
    NameModel(id: 191, sex: true, name: 'Зинаида', meaning: 'принадлежащая Зевсу, из рода Зевса, Зевсова'),
    NameModel(id: 192, sex: true, name: 'Злата', meaning: 'строгость'),
    NameModel(id: 193, sex: true, name: 'Иванна', meaning: 'помилованная Богом, Бог милостив'),
    NameModel(id: 194, sex: true, name: 'Инна', meaning: 'сильная вода, бурный поток'),
    NameModel(id: 195, sex: true, name: 'Ираида', meaning: 'героиня, дочь героя'),
    NameModel(id: 196, sex: true, name: 'Ирина', meaning: 'мир, покой'),
    NameModel(id: 197, sex: true, name: 'Ия', meaning: 'фиалка'),
    NameModel(id: 198, sex: true, name: 'Карина', meaning: 'киль корабля, вперед смотрящая  '),
    NameModel(id: 199, sex: true, name: 'Кира', meaning: 'повелительница, госпожа, солнце, престол'),
    NameModel(id: 200, sex: true, name: 'Клавдия', meaning: 'хромая, хромоножка'),
    NameModel(id: 201, sex: true, name: 'Клеопатра', meaning: 'слава отца, славная по отцу'),
    NameModel(id: 202, sex: true, name: 'Кристина', meaning: 'последовательница Христа'),
    NameModel(id: 203, sex: true, name: 'Ксения', meaning: 'гостеприимная, странница, чужестранка, гостья, чужая'),
    NameModel(id: 204, sex: true, name: 'Лариса', meaning: 'чайка'),
    NameModel(id: 205, sex: true, name: 'Лидия', meaning: 'лидиянка, жительница Лидии, азиатка, из Лидии'),
    NameModel(id: 206, sex: true, name: 'Лука', meaning: 'свет'),
    NameModel(id: 207, sex: true, name: 'Любовь', meaning: 'любимая'),
    NameModel(id: 208, sex: true, name: 'Людмила', meaning: 'милая людям'),
    NameModel(id: 209, sex: true, name: 'Маргарита', meaning: 'жемчужина, жемчуг'),
    NameModel(id: 210, sex: true, name: 'Марианна', meaning: 'печальная красавица'),
    NameModel(id: 211, sex: true, name: 'Марина', meaning: 'морская'),
    NameModel(id: 212, sex: true, name: 'Мария', meaning: 'горькая, желанная, безмятежная'),
    NameModel(id: 213, sex: true, name: 'Матрона', meaning: 'матрона, почтенная замужняя женщина, почтенная дама'),
    NameModel(id: 214, sex: true, name: 'Надежда', meaning: 'надеющаяся на лучшее'),
    NameModel(id: 215, sex: true, name: 'Наталья', meaning: 'родная'),
    NameModel(id: 216, sex: true, name: 'Наталия', meaning: 'рождественская, рожденная в Рождество, благословенная'),
    NameModel(id: 217, sex: true, name: 'Оксана', meaning: 'странница, чужестранка, гостеприимная'),
    NameModel(id: 218, sex: true, name: 'Ольга', meaning: 'святая, светлая, ясная, мудрая, священная, роковая'),
    NameModel(id: 219, sex: true, name: 'Пелагея', meaning: 'морская'),
    NameModel(id: 220, sex: true, name: 'Полина', meaning: 'посвященный Аполлону, Аполлонов'),
    NameModel(id: 221, sex: true, name: 'Прасковья', meaning: 'пятый день, пятница'),
    NameModel(id: 222, sex: true, name: 'Раиса', meaning: 'предводитель, главный'),
    NameModel(id: 223, sex: true, name: 'Римма', meaning: 'римлянка, яблочко, бросание, брошенное'),
    NameModel(id: 224, sex: true, name: 'Светлана', meaning: 'светлая, чистая'),
    NameModel(id: 225, sex: true, name: 'Севастьяна', meaning: 'высокочтимый'),
    NameModel(id: 226, sex: true, name: 'Серафима', meaning: 'жгучий, огненный'),
    NameModel(id: 227, sex: true, name: 'София', meaning: 'мудрость, разумность, наука'),
    NameModel(id: 228, sex: true, name: 'Софья', meaning: 'мудрая'),
    NameModel(id: 229, sex: true, name: 'Степанида', meaning: 'венценосная, венец, кольцо'),
    NameModel(id: 230, sex: true, name: 'Стефания', meaning: 'корона, диадема, венец'),
    NameModel(id: 231, sex: true, name: 'Таисия', meaning: 'посвященная Исиде'),
    NameModel(id: 232, sex: true, name: 'Тамара', meaning: 'пальма'),
    NameModel(id: 233, sex: true, name: 'Татта', meaning: 'отец, тятенька, крадущийся'),
    NameModel(id: 234, sex: true, name: 'Татьяна', meaning: 'устроительница, учредительница'),
    NameModel(id: 235, sex: true, name: 'Ульяна', meaning: 'счастье'),
    NameModel(id: 236, sex: true, name: 'Устинья', meaning: 'справедливая'),
    NameModel(id: 237, sex: true, name: 'Фаина', meaning: 'сияющая, блестящая'),
    NameModel(id: 238, sex: true, name: 'Феврония', meaning: 'вечное видение'),
    NameModel(id: 239, sex: true, name: 'Фекла', meaning: 'слава Божья'),
    NameModel(id: 240, sex: true, name: 'Фотиния', meaning: 'светлозарная'),
    NameModel(id: 241, sex: true, name: 'Христина', meaning: 'христианка, посвященная Христу'),
    NameModel(id: 242, sex: true, name: 'Юлиана', meaning: 'пушистая, кудрявая'),
  ];

  static List<String> babyGrowth = [
    '',
    '',
    '',
    '',
    '0.3 см',
    '0.5 см',
    '1.2 см',
    '1.6 см',
    '2.3 см',
    '3.1 см',
    '4.1 см',
    '5.4 см',
    '7.4 см',
    '8.7 см',
    '10.1 см',
    '11.6 см',
    '13 см',
    '14.2 см',
    '15.3 см',
    '25.6 см',
    '26.7 см',
    '27.8 см',
    '28.8 см',
    '30 см',
    '34.6 см',
    '35.6 см',
    '36.6 см',
    '37.5 см',
    '38.6 см',
    '39.9 см',
    '41.1 см',
    '42.4 см',
    '43.8 см',
    '45 см',
    '46.3 см',
    '47.4 см',
    '48.5 см',
    '49.8 см',
    '50.6 см',
    '51.2 см',
    '51.7 см',
    '52.6 см',
  ];

  static List<String> babyWeight = [
    '',
    '',
    '',
    '',
    '',
    '',
    '0.7 г',
    '1.1 г',
    '2 г',
    '4 г',
    '8 г',
    '14 г',
    '23 г',
    '43 г',
    '70 г',
    '100 г',
    '140 г',
    '190 г',
    '240 г',
    '300 г',
    '360 г',
    '430 г',
    '500 г',
    '600 г',
    '665 г',
    '760 г',
    '875 г',
    '1.1 кг',
    '1.15 кг',
    '1.3 кг',
    '1.5 кг',
    '1.7 кг',
    '1.9 кг',
    '2.15 кг',
    '2.4 кг',
    '2.6 кг',
    '2.9 кг',
    '3.1 кг',
    '3.2 кг',
    '3.4 кг',
    '3.6 кг',
    '3.7 кг',
  ];

  static List<String> babyCHSS = [
    '',
    '',
    '',
    '90-115',
    '90-115',
    '105-130',
    '105-130',
    '125-150',
    '125-150',
    '130-160',
    '130-160',
    '135-170',
    '135-170',
    '140-180',
    '140-180',
    '135-170',
    '135-170',
    '130-165',
    '130-165',
    '140-170',
    '140-170',
    '125-160',
    '125-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
    '120-160',
  ];

  static List<String> babyFruit = [
    'Меньше семечка мака',
    'Меньше семечка киви',
    'Семечко киви',
    'Кунжутное семечко',
    'Рисовое зернышко',
    'Ягода черники',
    'Семечка подсолнуха',
    'Горошинка',
    'Ягода малины',
    'Ягода вишни',
    'Клубника',
    'Слива',
    'Абрикос',
    'Лайм',
    'Авокадо',
    'Груша',
    'Персик',
    'Яблоко',
    'Апельсин',
    'Лимон',
    'Гранат',
    'Грейпфрут',
    'Манго',
    'Морковка',
    'Помело',
    'Банан',
    'Кукуруза',
    'Гроздь винограда',
    'Цуккини',
    'Баклажан',
    'Папайя',
    'Брокколи',
    'Ананас',
    'Кочан латука',
    'Дыня',
    'Кочан капусты',
    'Джекфрут',
    'Тыква',
    'Арбуз',
    'Арбуз',
    'Арбуз',
    'Арбуз',
  ];

  static List<String> babyDescription = [
    'За первый месяц у меня сформируются головка, тело, хвостик, сердечко. Сердечко уже начнёт сокращаться',
    'Во второй месяц у меня появятся ручки и ножки. Начинает развиваться мозг и нервная система. Появляются первые мышцы',
    'В 3-ем месяце ты уже можешь узнать кто я - мальчик или девочка. Я начинаю двигаться в животике, но мои движения ты пока не ощущаешь',
    'В четвертом месяце практически все мои органы сформированы. Я начинаю слышать твоё сердце',
    'В 5-ом месяце ты можешь начать ощущать мои движения. У меня уже появились волосики на голове. Я учусь глотать и дышать.',
    'В шестом месяце я начинаю активнее играть в твоём животике. Начинают формироваться зубки. У меня уже видны бровки.',
    'На седьмом месяце я отлично слышу и могу различить вкус. Я начинаю видеть сны. Иногда могу икать :)',
    'В 8-ой месяце я практически сформирован. Продолжаю расти и активно набираю вес. Переворачиваюсь головой вниз.',
    'Мне начинает быть тесно в животике. До нашей встречи осталось совсем немного времени. Буду рад встретиться с тобой, Мамочка',
  ];
}
