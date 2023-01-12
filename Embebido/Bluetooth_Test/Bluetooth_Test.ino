//#include <Arduino.h>
#include <strings.h>
#include <BluetoothSerial.h>
/* Definiciones 
- Maquina estados: 
    * espera  -> 1
    * abrir   -> 2
    * cerar   -> 3
    * valid   -> 4
    * config  -> 5*/
#define ValorInicial HIGH
#define espera  1
#define abrir 2
#define cerrar 3
#define valid 4
#define configu 5
#define EEPROM_SIZE 99


// Definición GPIOs
const int SW01 = 12;
const int SW02 = 4; 
int Sensor01 = 33; 
int Sensor02 = 26;
const int Sensor03 = 13; 
const int Sensor04 = 15;
const int CTL01 = 16;
const int CTL02 = 0;

// Variables de usuario 
volatile int estado = espera; 
String inputString = ""; 
String msg = "";
bool ReadyData = false;
volatile int Tiempo = 10;
bool StatusWifi = false;
bool StatusServer = false;
BluetoothSerial SerialBT;
String message = "";
String message2 = "";
char incomingChar;
char incomingChar2;


void InitGPIOs(void);
void Instrucciones(void);
//void ConfigByBluetooth(void);

void setup() {
    
  /*Configuracion de GPIOs*/
  //Salidas  
  pinMode(Sensor01,OUTPUT);         // Relevador 01
  pinMode(Sensor02,OUTPUT);         // Relevador 02

  //Entradas 
  pinMode(SW01, INPUT_PULLUP);      // Boton01 para configuracion  
  pinMode(SW02, INPUT_PULLUP);      // Boton02 para configuracion     
  /*Inicializacion de GPIOs*/
  InitGPIOs();
  /* Comunicacion UART*/
  Serial.begin(115200);
  Serial.println("----- Ventantana IoT -----"); // Solo se usa para habilitar terminal en wokwi 
  delay(500);
  
}

void loop() {
  /*Automata
  - Espera: Inicializado a la espera de configuración o comando para abrir 
  - Abrir: Secuencia de apertura
  - Cerrar: Secuencia para cerrar
  - Validación: 
  - Configuracion: A través de bluetooth se configura Red Wi-Fi 
  */
  switch(estado){
    case espera:
      if(ReadyData == true){
        Instrucciones(); 
        ReadyData = false; 
      }
      break;
    case abrir:
      Serial.println("Estado abrir");
      // Se habilita relay para abrir la puerta
      digitalWrite(Sensor01, LOW);
      delay(5000);
      // Se desabilita relay de abrir la puerta 
      digitalWrite(Sensor01, HIGH);
      /* Este retardo deberá poder ser configurable para que se modifique el tiempo 
      en el que la puerta está abierta */
      delay(5000);             
      estado = cerrar;
      break; 
    case cerrar:
      Serial.println("Estado cerrar");
      // Se habilita relay para cerrar la puerta
      digitalWrite(Sensor02, LOW);
      delay(5000); 
      // Se desabilita relay de cerrar la puerta 
      digitalWrite(Sensor02, HIGH);
      delay(5000); 
      estado = valid; 
      break;
    case valid:
      Serial.println("Proceso finalizado OK");
      estado = espera;
      break; 
    case configu:
      ConfigByBluetooth();
      estado = espera;
      break;
    default: 
      break;
  }
  while(Serial.available()){
    /* Lectura de nuevo byte por UART
    *** Recordar envíar salto de linea porque es lo que se detecta para finalizar */
    String RxData = Serial.readStringUntil('\n');
    // Imprimimos dado recibido 
    Serial.print(RxData);
    // Bandea ReadyData 
    ReadyData = true;
    // Guardamos dato recibido en msg 
    msg = RxData;
    // Limpiamos buffer RxData
    RxData = "";
  }
  if(digitalRead(SW01)== LOW){
    delay(3000);
    if (digitalRead(SW01)== LOW){
      estado = configu;
    }
  }
}

/*Funcion de instrucciones*/
void Instrucciones(void){
  Serial.println("Funcion Instrucciones"); // ****************
  Serial.println(msg);                        // ****************
  if(msg=="Abrir"){
    estado = abrir;
    Serial.println("Habilitamos secuencia de abrir");
    return;
  }else if(msg.compareTo("Alarma")==false){
    Serial.println("Habilitamos alarma");
    return;
  }else if(msg.compareTo("SET 25")==false){
    Serial.println("Habilitació");
    return;
  }else if(msg.compareTo("SET 50")==false){
    Serial.println("SET 50 OK");
    return;
  }else if(msg.compareTo("bluetooth config")==false){
    Serial.println("Inicializando bluetooth");
    estado = configu;
    return;
  }else if(msg.compareTo("SET 100")==false){
    Serial.println("SET 100");
    return;
  }else if(msg.compareTo("WiFi OK")==false){
    Serial.println("WiFi OK");
  }else if(msg.compareTo("SERVER OK")==false){ 
    Serial.println("SERVER OK");
    return;
  }else{
    Serial.println("NACK");
  }
}
/* Funcion para iniciar todas las salidas  */
void InitGPIOs(void){
  digitalWrite(Sensor01,ValorInicial);
  digitalWrite(Sensor02,ValorInicial);
}

void ConfigByBluetooth(void){
  // Inicializamos bluetooth 
  bool BTHControl = true;
  bool Flag_WiFi = false;
  bool Flag_BTH = false;
  bool Flag_Pass = false;
  bool Flag_User = false;
  SerialBT.begin("VentanaIoT");
  Serial.println("Bluetooth listo para emparejar ...");
  while(BTHControl==true){
    if(SerialBT.available()){
      char incomingChar = SerialBT.read();
      if (incomingChar != '\n'){
        message += String(incomingChar);
      }
      else{
        //BTHControl = false;
        message = "";
      }
      Serial.write(incomingChar);
    }
    if (message =="Reset"){
      BTHControl = false;
      }
    if(Serial.available()){
      char incomingChar2 = Serial.read();
      if (incomingChar2 != '\n'){
        message2 += String(incomingChar2);
      }
      else{
        //BTHControl = false;
        message2 = "";
      }
      SerialBT.write(incomingChar2);
    } 
  }
  SerialBT.end();
  Serial.println("Bluetooth deshabilitado ... ");
}
