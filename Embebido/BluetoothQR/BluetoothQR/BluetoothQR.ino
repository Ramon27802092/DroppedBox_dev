/*Codigo funcional para lector bluetooth
 Es necesario revisar gpio a Raspberry*/
#include <BluetoothSerial.h>
#define Btn1_GPIO   35
#define LED1_GPIO   5

BluetoothSerial SerialBT;
void ConfigByBluetooth(void);

void setup()
{
  pinMode(LED1_GPIO, OUTPUT);
  pinMode(Btn1_GPIO, INPUT_PULLUP);
  Serial.begin(115200);
  Serial.println("Inico de codigo");
}
 
void loop()
{
  if(digitalRead(Btn1_GPIO)== LOW){
    Serial.println("Boton presionado");
    delay(2000);
    if(digitalRead(Btn1_GPIO) == LOW){
      Serial.println("Sigue presionado");
      while(digitalRead(Btn1_GPIO) == LOW);
      Serial.println("Liberado");
      digitalWrite(LED1_GPIO,HIGH);
      ConfigByBluetooth();
      digitalWrite(LED1_GPIO,LOW);
    }
  }
}

void ConfigByBluetooth(void){
  // Inicializamos bluetooth
  String message = "";
  String message2 = "";
  char incomingChar;
  char incomingChar2; 
  bool BTHControl = true;
  SerialBT.begin("LectorQR");
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
}
