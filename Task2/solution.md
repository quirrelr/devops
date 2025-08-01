# Этот файл является решением для файла [README_RUS-4.md](/Task%202/README_RUS-4.md)

## Part 1. Инструмент ipcalc
#### 1.1. Сети и маски
**Адрес сети 192.167.38.54/13**: 192.167.38.54

На примере маски **255.255.255.0** рассмотрим перевод маски в двоичную и префиксную форму вручную. Он осуществляется следующим образом:
- В десятичной пишутся просто 4 числа от 0 до 255 (т.к. в IPv4 используется 4 байта для кодирования маски).
- В двоичной эти 4 байта записываются побитово.
- В префиксной записывается количество единиц в двоичной записи 4 байтов.

**Двоичная и префиксная записи маски 255.255.255.0:**\
11111111.11111111.11111111.00000000\
/24

*Т.к. выполняемые действия несложные и повторяются, я решил не делать скрины выполнения команды ipcalc, а только записывать результаты.*

**/15 в двоичной и обычной**: \
11111111.11111110.00000000.00000000 \
255.254.0.0

**11111111.11111111.11111111.11110000 в обычной и префиксной:** \
255.255.255.240 (Оказалось что ipcalc не принимает двоичную запись на прямую, поэтому пришлось воспользоваться калькулятором) \
/28

**Минимальные и максимальные хосты в сети 12.167.38.4 при масках:** 

**/8** \
Min: 12.0.0.1\
Max: 12.255.255.254

**11111111.11111111.00000000.00000000** \
Min: 12.167.0.1\
Max: 12.167.255.254

**255.255.254.0** \
Min: 12.167.38.1\
Max: 12.167.39.254

**/4** \
Min: 0.0.0.1\
Max: 15.255.255.254

**О том, как вычисляются минимальные и максимальные хосты на примере 12.167.38.4/23:** 
1. Переведем маску в двоичную запись:\
   `11111111.11111111.11111110.00000000`
2. Найдем хостовую часть проинвертировав маску: \
   `00000000.00000000.00000001.11111111`
3. Из хостовой части мы можем вычислить количество хостов:\
   `111111111 (в двоичной) = 512 (в десятичной)` \
   а также сделать вывод о том, что в нашей сети находятся 2 подсети класса С - подсети с маской /24.
4. Теперь переведем адрес в двоичную запись: \
   `00001100.10100111.00100110.00000100`\
   И обнулим все биты хостовой части: \
   `00001100.10100111.00100110.00000000` \
   Переведем двоичную запись в десятичную:\
   `12.167.38.0` - это **адрес сети**\

*Адрес сети (network address) — это первый адрес в IP-подсети, который обозначает саму сеть, а не отдельное устройство.*

5. В хостовой части ставим единицы:
   `00001100.10100111.00100111.11111111` \
   Переведем двоичную запись в десятичную: \
   `12.167.39.255` - это **broadcast**

*Широковещательный адрес (broadcast address) - это последний адрес в IP-подсети, который используется, чтобы послать пакет всем в подсети.*

6. Все адреса между network и broadcast являются хостовыми  и таким образом мы можем найти минимальный и максимальный хост.\
   `Min = network + 1` \
   `Max = broadcast - 1`

#### 1.2. localhost

*localhost — это псевдоним для IP-адреса, который используется для связи программ внутри одной машины, без выхода в сеть.*

**По умолчанию localhost - это эквивалент 127.0.0.1, но может быть и любой другой адрес из диапазона 127.0.0.0/8**

Отсюда понятно, что по всем адресам типа 127.x.x.x возможно обратиться к localhost, а это: \
**127.0.0.2, 127.1.0.1**

#### 1.3. Диапазоны и сегменты сетей

Для частных сетей существуют три зарезервированных диапазона
1. 10.0.0.0/8 - Класс А
2. 172.16.0.0/12 - Класс B
3. 192.168.0.0/16 - Класс C

Так мы можем разделить данные в задании сети на частные и публичные.\
**Частные:**\
10.0.0.45, 192.168.4.2, 172.16.255.255, 10.10.10.10 \
**Публичные:** \
134.43.0.2, 172.20.250.4, 172.0.2.1, 192.172.0.1, 172.68.0.2, 192.169.168.1

У сети 10.10.0.0/18 \
Минимальный хост: 10.10.0.1
Максимальный хост: 10.10.63.254
**Возможны следующие адресы шлюза:** \
10.10.0.2, 10.10.10.10,, 10.10.1.255
## Part 2. Статическая маршрутизация между двумя машинами
**Вывод команды ip a для** \
ws1
![](/Task%202/source/d2-p2-3.png) \
ws2
![](/Task%202/source/d2-p2-4.png)

**Содержимое 00-installer-config.yaml для** \
ws1 \
![](/Task%202/source/d2-p2-1.png) \
ws2 \
![](/Task%202/source/d2-p2-2.png)

#### 2.1. Добавление статического маршрута вручную

Здесь вышло несколько трудностей:
1. Я пытался добавить через ip r add не сеть, а конкретный хост. Надо добавлять сеть и ее адрес можно легко вычислить с помощью ipcalc.
2. Ну и кто бы догадался просто дать машинам два адреса. Фактически передачи пакетов не происходи - они не покидают интерфейс.

**Пинг** \
ws2 с ws1 \
![](/Task%202/source/d2-p2-5.png) \
ws1 с ws2 \
![](/Task%202/source/d2-p2-6.png)

## Part 3. Утилита iperf
#### 3.1. Скорость соединения
8 Mbps = 1 MB/s \
100 MB/s = 800 000 Kbps \
1 Gbps = 1000 Mbps
#### 3.2. Утилита iperf
`Без комментариев...` 

## Part 4. Межсетевой экран
## Part 5. Статическая маршрутизация сети
**netplan конфиги** \
ws11 \
![](/Task%202/source/d2-p5-1.png) \
r1 \
![](/Task%202/source/d2-p5-2.png) \
r2 \
![](/Task%202/source/d2-p5-3.png) \
ws21 \
![](/Task%202/source/d2-p5-4.png) \
ws22 \
![](/Task%202/source/d2-p5-5.png)

*В задании к успешной связке 5 машин подходят поэтапно и с полной отчетностью. Я немного перестарался и сделал все сразу правильно, обходя промежуточные этапы. Поэтому тут будут только скрины окончательных yaml.*

**Успешный пинг r2 с ws11** \
![](/Task%202/source/d2-p5-6.png)

**Успешный пинг ws21 с ws11** \
![](/Task%202/source/d2-p5-8.png)

**Список адресов, через которые прошли пакеты на пути от ws11 до ws21**
![](/Task%202/source/d2-p5-7.png)
![](/Task%202/source/network.jpg)

**Пинг несуществующего адреса** \
![](/Task%202/source/d2-p5-9.png)

**Работающий isc dhcp на r2** \
![](/Task%202/source/d2-p5-10.png)

**Динамически выданный адрес ws21** \
![](/Task%202/source/d2-p5-11.png)

*На динамической адресации я кстати сидел больше часа потому что настраивал файл /etc/dhcp/dhcp.conf (которого вообще не существовало), а не /etc/dhcp/dhcpd.conf. Дол-ба..*

**netplan для ws11**
![](/Task%202/source/d2-p5-12.png)

Когда я проводил те же операции на r1, но с жесткой привязкой по mac-адресу, то появилась проблема:
Сервер получал запрос на выдачу ip-адреса через bc. Затем он связывал данного клиента с записанным в dhcp конфиге ip-адресом по мак-адресу и ТУДА же отдавал ответ. НО! Клиент не получил данный ответ естественно, т.к. он по этому ip адресу не находится.
Решением стала отправка dhcp оффера на bc.

**Обновление ip-адреса c ws21** \
![](/Task%202/source/d2-p6-2.png) \
Из-за постоянной выдачи одного и того же адреса клиенту, я засомневался. Поэтому после задания адреса клиенту я изменил правила выдачи адресов на сервере и снова запросил новый адрес - сработало.

**Адрес ws11, полученный по мак адресу**
![](/Task%202/source/d2-p6-3.png)

## Part 7. NAT

**Конфиг портов для ws22 и r1** \
![](/Task%202/source/d2-p7-1.png)

**Запуск Apache на** \
ws22 \
![](/Task%202/source/d2-p7-2.png) \
r1 \
![](/Task%202/source/d2-p7-3.png)

**Пинг r1 с ws22 (неудачно как и должно быть по заданию)** \
![](/Task%202/source/d2-p7-4.png)

**Пинг ws22 c r1 после изменения фаерволла** \
![](/Task%202/source/d2-p7-5.png)

**Прослушиваю внешний адаптер r2 и пингую 1.1.1.1 с ws21** \
![](/Task%202/source/d2-p7-6.png) \
По выводу tcpdump убедился, что роутер подставляет свой айпи при передаче пакетов во внешнюю сеть.

У меня возникли некоторые сложности на этапе со SNAT и DNAT, поэтому фаерволл пришлось переписать с нуля.

**Фаерволл на r2** \
![](/Task%202/source/d2-p7-7.png)

*Теперь я бы хотел сказать немного больше об iptables, т.к. это оказалось не легким для меня, хотелось бы разобраться.*

iptables - это утилита для настройки фаервола и NAT (Network Address Translation). Она работает с сетевыми пакетами на уровне ядря и решает, что с ними делать: пропускать, блокировать, перенаправлять и т.д.

iptables работает с несколькими таблицами:
1. **filter** - это основная таблица для фильтрации трафика и используется по умолчанию.
2. **nat** - таблица для NAT (DNAT, SNAT, MASQUERADE)
3. **mangle** - маркировка и изменение пакетов
4. **raw** - включение/отключение connection tracking.

Каждый пакет проходит цикл состоящий из нескольких этапов:

1. **PREROUTING** — пакет только пришёл (до маршрутизации). Здесь делается DNAT, т.к. мы можем поменять адрес, куда пакет будет направлен.

2. **ROUTING DECISION** — ядро определяет, куда направить пакет (FORWARD, INPUT или OUTPUT).

3. **FORWARD** / **INPUT** / **OUTPUT** — обработка пакета по цепочке (принять себе, переслать дальше и т.д.).

4. **POSTROUTING** — пакет уже готовится к отправке наружу через интерфейс. Здесь выполняется SNAT, т.к. ядро не знает, нужно ли подменять source IP, пока не определит, куда пойдет этот пакет.

И основные действия с пакетами:

1. **ACCEPT** - пропускает пакет дальше.
2. **DROP** - блокирует пакет молча (игнорируется).
3. **REJECT** - блокирует пакет, отправляя ICMP-ошибку (или TCP RST).
4. **DNAT** - Меняет Destination IP/port пакета.
5. **SNAT** - меняет Source IP/port пакета.
6. **MASQUERADE** - динамический SNAT (подменяет Source IP на IP интерфейса).
7. **LOG** - логирует пакет в syslog, не прерывая обработку.
8. **RETURN** - выход из текущей цепочки (возвращается на уровень выше).
9. **QUEUE** - передаёт пакет в userspace (например, для фильтрации через программы).

Используя данные действия и добавляя ключи, цепочки и таблицы, а так же добавляя ключи и адреса, можно настроить фаервол и NAT.

Я проверил работоспособность фаервола с помощью tcpdump и telnet (команда которая устанавливает tcp-соединение к указанному IP и порту).

**Успешное tcp соединение с ws22 до r1**
![](/Task%202/source/d2-p7-9.png)

**Прослушивание на r1**
![](/Task%202/source/d2-p7-8.png)

По выводу tcpdump можно легко понять, что запросы и ответы идут с/на адрес r2 (10.100.0.12). \
Вывод: **SNAT работает**.

**Успешное tcp соединение с r1 до ws22**
![](/Task%202/source/d2-p7-10.png)
**Прослушивание на ws22**
![](/Task%202/source/d2-p7-11.png)

Кстати, здесь пришлось внести еще одно изменение в фаервол - а именно интерфейс для DNAT, т.к. изначально я проверял работоспособность фаервола по внешнему клиенту. \
Вывод: **DNAT работает**.

## Part 8. Дополнительно. Знакомство с SSH Tunnels

**Подключение к ws22 с ws21 через Local TCP Forwarding**
![](/Task%202/source/d2-p8-1.png)

**Подключение к ws22 с ws11 через Remote TCP Forwarding**
![](/Task%202/source/d2-p8-2.png)