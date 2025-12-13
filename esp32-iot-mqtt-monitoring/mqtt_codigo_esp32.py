import network, time, machine, ubinascii
from umqtt.simple import MQTTClient
import dht

# Wi-Fi
WIFI_SSID, WIFI_PASS = "Wokwi-GUEST", ""

# Blynk MQTT
BLYNK_HOST, BLYNK_PORT = "ny3.blynk.cloud", 8883
BLYNK_USER, BLYNK_TOKEN = "device", "REMOVIDO"
CLIENT_ID = b"esp32-" + ubinascii.hexlify(machine.unique_id())

# Tópicos (nomes dos Datastreams)
PUB_TEMP      = b"ds/Temperatura"
PUB_HUM       = b"ds/Umidade"
PUB_AQUEC     = b"ds/Rele aquecedor"   # estado 0/1
PUB_EXAUSTOR  = b"ds/Exaustor"         # estado 0/1
PUB_ALARME    = b"ds/Alarme"           # reflete LED azul 0/1
SUB_ALARME    = b"downlink/ds/Alarme"  # comando 0/1
SUB_TEMP      = b"downlink/ds/Temperatura"
REQ_DS        = b"get/ds"

# Pinos
PIN_DHT, PIN_LED, PIN_R1, PIN_R2 = 15, 27, 12, 4
sensor = dht.DHT22(machine.Pin(PIN_DHT))
led    = machine.Pin(PIN_LED, machine.Pin.OUT, value=0)
r1     = machine.Pin(PIN_R1,  machine.Pin.OUT, value=0)  # aquecedor
r2     = machine.Pin(PIN_R2,  machine.Pin.OUT, value=0)  # exaustor

# Estado
TH_LOW, TH_HIGH = 35.0, 45.0
PUBLISH_MS = 5000
TEMP_RX = None

def wifi():
    sta = network.WLAN(network.STA_IF); sta.active(True)
    if not sta.isconnected():
        sta.connect(WIFI_SSID, WIFI_PASS)
        while not sta.isconnected(): time.sleep_ms(200)

def on_msg(topic, msg):
    global TEMP_RX
    if topic == SUB_ALARME:
        v = 1 if msg.strip().lower() in (b"1", b"true", b"on", b"high") else 0
        led.value(v)
        client.publish(PUB_ALARME, b"1" if v else b"0")  # mostra no dashboard
    elif topic == SUB_TEMP:
        try: TEMP_RX = float(msg)
        except: TEMP_RX = None

def mqtt_connect():
    c = MQTTClient(CLIENT_ID, BLYNK_HOST, port=BLYNK_PORT,
                   user=BLYNK_USER, password=BLYNK_TOKEN,
                   keepalive=45, ssl=True, ssl_params={"server_hostname": BLYNK_HOST})
    c.set_callback(on_msg)
    c.connect()
    c.subscribe(SUB_ALARME)
    c.subscribe(SUB_TEMP)
    c.publish(REQ_DS, b"Temperatura")  # pede valor atual
    return c

def reconnect():
    global client
    try: client.disconnect()
    except: pass
    time.sleep_ms(500)
    client = mqtt_connect()

wifi()
client = mqtt_connect()

last = 0
while True:
    try:
        client.check_msg()
        now = time.ticks_ms()
        if time.ticks_diff(now, last) > PUBLISH_MS:
            last = now

            # publica leitura local
            try:
                sensor.measure()
                t = sensor.temperature(); h = sensor.humidity()
                client.publish(PUB_TEMP, ("%.1f" % t).encode())
                client.publish(PUB_HUM,  ("%.1f" % h).encode())
            except:
                pass

            # usa TEMP_RX para os relés e publica estados
            if TEMP_RX is None:
                r1.value(0); r2.value(0)
            elif TEMP_RX < TH_LOW:
                r1.value(1); r2.value(0)
            elif TEMP_RX > TH_HIGH:
                r1.value(0); r2.value(1)
            else:
                r1.value(0); r2.value(0)

            client.publish(PUB_AQUEC,   b"1" if r1.value() else b"0")
            client.publish(PUB_EXAUSTOR,b"1" if r2.value() else b"0")

            client.publish(REQ_DS, b"Temperatura")  # reconsulta para manter TEMP_RX
    except:
        reconnect()
    time.sleep_ms(50)
