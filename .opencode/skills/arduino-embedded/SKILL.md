---
name: arduino-embedded
description: Expert Arduino and embedded systems development with ESP8266/ESP32, ATmega328/2560, sensors, displays, motor controllers, I2C/SPI communication, menu systems, and hardware interfacing
metadata:
  platforms: arduino,esp8266,esp32,atmega328,atmega2560
  protocols: i2c,spi,uart,onewire,pwm,adc
  ide: arduino-ide,platformio
  level: expert
---

## What I do
- Develop firmware for Arduino boards (Uno, Nano, Mega, Leonardo, Due)
- Program ESP8266 and ESP32 (WiFi, Bluetooth, Deep Sleep)
- Interface sensors: DHT11/22, BMP280, BME680, DS18B20, MPU6050, HC-SR04, MQ-135, LDR, IR
- Control displays: LCD 16x2/20x4 (HD44780), OLED SSD1306/SH1106, TFT ILI9341/ST7735, MAX7219 LED Matrix
- Drive motors: DC, servo, stepper (28BYJ-48, NEMA17), L298N, L293D, A4988, DRV8825
- Build menu systems with rotary encoder, buttons, and display navigation
- Implement I2C, SPI, UART, OneWire, and custom protocols
- Design power-efficient systems with Deep Sleep and watchdog timers
- Create IoT projects with MQTT, HTTP, WebSocket, OTA updates
- Use PlatformIO for professional embedded development

## When to use me
Use this skill for any Arduino, ESP8266, ESP32, or ATmega-based project. Covers firmware development, sensor integration, motor control, display interfaces, menu systems, IoT connectivity, and hardware troubleshooting.

## Arduino Board Reference

### ATmega Family
| Board | MCU | Digital I/O | Analog In | Flash | RAM | Clock |
|-------|-----|-------------|-----------|-------|-----|-------|
| Uno | ATmega328P | 14 | 6 | 32KB | 2KB | 16MHz |
| Nano | ATmega328P | 14 | 6 | 32KB | 2KB | 16MHz |
| Mega | ATmega2560 | 54 | 16 | 256KB | 8KB | 16MHz |
| Leonardo | ATmega32U4 | 20 | 12 | 32KB | 2.5KB | 16MHz |
| Due | SAM3X8E | 54 | 12 | 512KB | 96KB | 84MHz |

### ESP Family
| Board | Chip | WiFi | BT | Flash | RAM | Clock |
|-------|------|------|-----|-------|-----|-------|
| ESP8266 | ESP8266EX | 2.4GHz | No | 4MB | 80KB | 80MHz |
| ESP32 | ESP32 | 2.4GHz | 4.2 | 4MB | 520KB | 240MHz |
| ESP32-S2 | ESP32-S2 | 2.4GHz | No | 4MB | 320KB | 240MHz |
| ESP32-S3 | ESP32-S3 | 2.4GHz | 5.0 | 4MB | 512KB | 240MHz |
| ESP32-C3 | ESP32-C3 | 2.4GHz | 5.0 | 4MB | 400KB | 160MHz |

## Pin Reference

### Arduino Uno/Nano (ATmega328P)
```
Digital:  D0-D13 (D0/D1 = Serial RX/TX)
PWM:      D3, D5, D6, D9, D10, D11 (~)
Analog:   A0-A5
I2C:      A4 (SDA), A5 (SCL)
SPI:      D10 (SS), D11 (MOSI), D12 (MISO), D13 (SCK)
Interrupts: D2 (INT0), D3 (INT1)
```

### Arduino Mega (ATmega2560)
```
Digital:  D0-D53
PWM:      D2-D13, D44-D46
Analog:   A0-A15
I2C:      A4 (SDA), A5 (SCL)  OR  D20 (SDA), D21 (SCL)
SPI:      D53 (SS), D51 (MOSI), D50 (MISO), D52 (SCK)
Interrupts: D2 (INT0), D3 (INT1), D18-INT5 (INT2-INT5)
```

### ESP32
```
Digital:  GPIO0-GPIO39
ADC:      GPIO0-GPIO39 (ADC1: 0-39, ADC2: 0-39 but WiFi uses some)
I2C:      GPIO21 (SDA), GPIO22 (SCL)
SPI:      GPIO5 (SS), GPIO23 (MOSI), GPIO19 (MISO), GPIO18 (SCK)
PWM:      Any GPIO (LEDC channels)
Touch:    GPIO0-GPIO14
```

## Sensor Library

### Temperature & Humidity
```cpp
// DHT22 - Digital Temperature/Humidity
#include <DHT.h>
#define DHT_PIN 2
#define DHT_TYPE DHT22
DHT dht(DHT_PIN, DHT_TYPE);

float temp = dht.readTemperature();    // Celsius
float hum = dht.readHumidity();        // Percent
float heatIndex = dht.computeHeatIndex(temp, hum, false);

// DS18B20 - Waterproof Digital Temperature (OneWire)
#include <OneWire.h>
#include <DallasTemperature.h>
OneWire oneWire(4);
DallasTemperature sensors(&oneWire);
sensors.requestTemperatures();
float tempC = sensors.getTempCByIndex(0);

// BMP280 - Barometric Pressure/Temperature
#include <Wire.h>
#include <Adafruit_BMP280.h>
Adafruit_BMP280 bmp;
float temp = bmp.readTemperature();
float pressure = bmp.readPressure() / 100.0F; // hPa
float altitude = bmp.readAltitude(1013.25);    // meters
```

### Motion & Orientation
```cpp
// MPU6050 - Accelerometer + Gyroscope (I2C)
#include <Wire.h>
#include <MPU6050_tockn.h>
MPU6050 mpu(Wire);
mpu.update();
float accX = mpu.getAccX();
float accY = mpu.getAccY();
float accZ = mpu.getAccZ();
float gyroX = mpu.getGyroX();
float gyroY = mpu.getGyroY();
float gyroZ = mpu.getGyroZ();

// HC-SR04 - Ultrasonic Distance
#define TRIG 9
#define ECHO 10
digitalWrite(TRIG, HIGH);
delayMicroseconds(10);
digitalWrite(TRIG, LOW);
long duration = pulseIn(ECHO, HIGH);
float distance = duration * 0.034 / 2.0; // cm
```

### Gas & Air Quality
```cpp
// MQ-135 - Air Quality (CO2, NH3, Benzene)
int analogValue = analogRead(A0);
float ppm = map(analogValue, 0, 1023, 0, 1000);

// MQ-2 - Gas/Smoke/Combustible Gas
int smokeLevel = analogRead(A0);
```

### Light & Color
```cpp
// BH1750 - Light Intensity (I2C)
#include <Wire.h>
#include <BH1750.h>
BH1750 lightMeter;
float lux = lightMeter.readLightLevel(); // lux

// TCS34725 - RGB Color Sensor (I2C)
#include <Wire.h>
#include <Adafruit_TCS34725.h>
Adafruit_TCS34725 tcs = Adafruit_TCS34725();
uint16_t r, g, b, c;
tcs.getRawData(&r, &g, &b, &c);
```

## Display Library

### LCD HD44780 (16x2 / 20x4)
```cpp
#include <LiquidCrystal.h>
LiquidCrystal lcd(12, 11, 5, 4, 3, 2); // RS, E, D4, D5, D6, D7

lcd.begin(16, 2);         // 16 cols, 2 rows
lcd.clear();
lcd.setCursor(0, 0);      // col, row
lcd.print("Hello World!");
lcd.setCursor(0, 1);
lcd.print("Temp: ");
lcd.print(temp);
lcd.print(" C");

// With I2C Backpack
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27, 16, 2); // addr, cols, rows
lcd.init();
lcd.backlight();
```

### OLED SSD1306 (128x64 I2C)
```cpp
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64
#define OLED_RESET -1
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

display.begin(SSD1306_SWITCHCAPVCC, 0x3C); // addr
display.clearDisplay();
display.setTextSize(1);      // 1=small, 2=medium, 3=large
display.setTextColor(SSD1306_WHITE);
display.setCursor(0, 0);
display.println("Temperature:");
display.setTextSize(2);
display.print(temp, 1);
display.println(" C");
display.display();
```

### TFT ILI9341 (240x320 SPI)
```cpp
#include <SPI.h>
#include <Adafruit_GFX.h>
#include <Adafruit_ILI9341.h>
#define TFT_CS 10
#define TFT_DC 9
#define TFT_RST 8
Adafruit_ILI9341 tft(TFT_CS, TFT_DC, TFT_RST);

tft.begin();
tft.setRotation(3);        // Landscape
tft.fillScreen(ILI9341_BLACK);
tft.setTextColor(ILI9341_WHITE);
tft.setTextSize(2);
tft.setCursor(10, 10);
tft.println("Arduino Dashboard");
tft.drawCircle(100, 100, 50, ILI9341_GREEN);
tft.fillRect(10, 150, 220, 40, ILI9341_BLUE);
```

### MAX7219 LED Matrix (8x8)
```cpp
#include <LedControl.h>
LedControl lc = LedControl(12, 11, 10, 1); // DIN, CLK, CS, NUM_DEVICES
lc.shutdown(0, false);      // Wake up
lc.setIntensity(0, 8);      // Brightness 0-15
lc.clearDisplay(0);

// Set individual LED
lc.setLed(0, row, col, true);   // row 0-7, col 0-7

// Set character
lc.setChar(0, 0, 'A', false);

// Set row (binary pattern)
lc.setRow(0, 0, B10101010);
```

## Motor Control

### Servo
```cpp
#include <Servo.h>
Servo myServo;
myServo.attach(9);           // Pin
myServo.write(90);           // Angle 0-180
int angle = myServo.read();  // Current angle

// ESP32 LEDC Servo (no library needed)
ledcSetup(0, 50, 16);       // channel, freq, resolution
ledcAttachPin(18, 0);
ledcWrite(0, 1638);         // 1.5ms pulse = 90°
```

### DC Motor with L298N
```cpp
#define IN1 7
#define IN2 8
#define ENA 9   // PWM speed control

// Forward
digitalWrite(IN1, HIGH);
digitalWrite(IN2, LOW);
analogWrite(ENA, 200);      // Speed 0-255

// Backward
digitalWrite(IN1, LOW);
digitalWrite(IN2, HIGH);
analogWrite(ENA, 200);

// Brake
digitalWrite(IN1, LOW);
digitalWrite(IN2, LOW);
```

### Stepper Motor (28BYJ-48)
```cpp
#include <Stepper.h>
#define STEPS_PER_REV 2048
Stepper stepper(STEPS_PER_REV, 8, 10, 9, 11); // IN1, IN3, IN2, IN4

stepper.setSpeed(10);        // RPM
stepper.step(STEPS_PER_REV); // 1 revolution
stepper.step(-1024);         // half revolution reverse

// A4988/DRV8825 (NEMA17)
#define STEP_PIN 3
#define DIR_PIN 2
#define ENABLE_PIN 4

digitalWrite(ENABLE_PIN, LOW);  // Enable driver
digitalWrite(DIR_PIN, HIGH);    // Direction
for (int i = 0; i < 200; i++) { // 200 steps = 1 rev (1.8°/step)
    digitalWrite(STEP_PIN, HIGH);
    delayMicroseconds(500);
    digitalWrite(STEP_PIN, LOW);
    delayMicroseconds(500);
}
```

## Menu System Pattern

### Button Navigation with LCD
```cpp
#include <LiquidCrystal_I2C.h>
#include <Bounce2.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);

#define BTN_UP 2
#define BTN_DOWN 3
#define BTN_SELECT 4
#define BTN_BACK 5

Bounce btnUp = Bounce(BTN_UP, 50);
Bounce btnDown = Bounce(BTN_DOWN, 50);
Bounce btnSelect = Bounce(BTN_SELECT, 50);
Bounce btnBack = Bounce(BTN_BACK, 50);

enum MenuItem { MENU_TEMP, MENU_MOTOR, MENU_DISPLAY, MENU_WIFI, MENU_COUNT };
MenuItem currentMenu = MENU_TEMP;
const char* menuItems[] = {"Temperature", "Motor", "Display", "WiFi"};
const int menuCount = 4;

void setup() {
    lcd.init();
    lcd.backlight();
    pinMode(BTN_UP, INPUT_PULLUP);
    pinMode(BTN_DOWN, INPUT_PULLUP);
    pinMode(BTN_SELECT, INPUT_PULLUP);
    pinMode(BTN_BACK, INPUT_PULLUP);
}

void loop() {
    btnUp.update();
    btnDown.update();
    btnSelect.update();
    
    if (btnUp.fell()) {
        currentMenu = (currentMenu - 1 + menuCount) % menuCount;
        displayMenu();
    }
    if (btnDown.fell()) {
        currentMenu = (currentMenu + 1) % menuCount;
        displayMenu();
    }
    if (btnSelect.fell()) {
        executeMenu(currentMenu);
    }
}

void displayMenu() {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print(">");
    lcd.print(menuItems[currentMenu]);
    lcd.setCursor(0, 1);
    int next = (currentMenu + 1) % menuCount;
    lcd.print(" ");
    lcd.print(menuItems[next]);
}

void executeMenu(MenuItem item) {
    switch (item) {
        case MENU_TEMP: showTemperature(); break;
        case MENU_MOTOR: controlMotor(); break;
        case MENU_DISPLAY: adjustDisplay(); break;
        case MENU_WIFI: configureWiFi(); break;
    }
}
```

### Rotary Encoder Menu
```cpp
#define ENCODER_A 2
#define ENCODER_B 3
#define ENCODER_BTN 4
volatile int encoderPos = 0;
int lastEncoderPos = 0;

void encoderISR() {
    if (digitalRead(ENCODER_B)) {
        encoderPos++;
    } else {
        encoderPos--;
    }
}

void setup() {
    attachInterrupt(digitalPinToInterrupt(ENCODER_A), encoderISR, RISING);
    pinMode(ENCODER_BTN, INPUT_PULLUP);
}

void loop() {
    if (encoderPos != lastEncoderPos) {
        int menuIndex = constrain(encoderPos / 4, 0, menuCount - 1);
        displayMenu(menuIndex);
        lastEncoderPos = encoderPos;
    }
    if (!digitalRead(ENCODER_BTN)) {
        executeMenu(encoderPos / 4);
        delay(200); // debounce
    }
}
```

## I2C Scanner
```cpp
#include <Wire.h>
void setup() {
    Wire.begin();
    Serial.begin(9600);
    Serial.println("I2C Scanner Scanning...");
    for (byte addr = 1; addr < 127; addr++) {
        Wire.beginTransmission(addr);
        if (Wire.endTransmission() == 0) {
            Serial.print("Device found at 0x");
            Serial.println(addr, HEX);
        }
    }
}
```

## ESP32 Deep Sleep
```cpp
#define uS_TO_S_FACTOR 1000000ULL
#define TIME_TO_SLEEP 30  // seconds

void setup() {
    esp_sleep_enable_timer_wakeup(TIME_TO_SLEEP * uS_TO_S_FACTOR);
    esp_deep_sleep_start();
}
```

## PlatformIO Configuration
```ini
; platformio.ini
[env:uno]
platform = atmelavr
board = uno
framework = arduino
lib_deps = 
    adafruit/DHT sensor library
    adafruit/Adafruit SSD1306
    paulstoffregen/TimerOne

[env:esp32]
platform = espressif32
board = esp32dev
framework = arduino
monitor_speed = 115200
lib_deps = 
    adafruit/DHT sensor library
    adafruit/Adafruit BME280 Library
build_flags = -DCORE_DEBUG_LEVEL=4

[env:mega]
platform = atmelavr
board = megaatmega2560
framework = arduino
```

## Best Practices
- Use `const` and `#define` for pin numbers and constants
- Avoid `delay()` in production; use `millis()` for timing
- Use `Bounce2` library for button debouncing
- Implement watchdog timer for reliability
- Use `volatile` for variables modified in ISRs
- Keep ISRs short; set flags, process in loop()
- Use `F()` macro to store strings in flash on AVR
- Power management: disable unused peripherals
- Use `PROGMEM` for large constant arrays on AVR
- Test with real hardware; simulators have limitations
