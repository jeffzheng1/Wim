
#include <SPI.h>
#include <Ethernet2.h>
#include <String.h>
#include <ctype.h>

byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };

char server[] = "api.parse.com";    // name address for Google (using DNS)

IPAddress ip(192, 168, 0, 177);

EthernetClient client;
long unsigned int pause = 5000;  

boolean lockLow = true;
boolean takeLowTime;  

int pirEntryPin = 3; //the digital pin connected to the PIR sensor's output
int pirExitPin = 4; 
int RPin = 5;
int GPin = 6;
int BPin = 7;

int calibrationTime = 30; //give 30 seconds for PIR sensors calibration
unsigned long lastConnectionTime = 0;             // last time you connected to the server, in milliseconds
const unsigned long postingInterval = 10L * 1000L; // delay between updates, in milliseconds
// the "L" is needed to use long type numbers

void setup() {
  
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }

  // start the Ethernet connection:
  Serial.println("Hello\n");
  if(Ethernet.begin(mac)==0){
    Serial.println("Unable to get DHCP IP\n");
    Ethernet.begin(mac, ip);
  }
  
  pinMode(pirEntryPin, INPUT);
  pinMode(pirExitPin, INPUT);
  pinMode(RPin, OUTPUT);
  pinMode(GPin, OUTPUT);
  pinMode(BPin, OUTPUT);
  digitalWrite(pirEntryPin, LOW);
  digitalWrite(pirExitPin, LOW);
  
  //give the sensor some time to calibrate
  Serial.print("calibrating sensor ");
  for(int i = 0; i < calibrationTime; i++){
    Serial.print(".");
    delay(1000);
  }   
  Serial.println(" done");
  Serial.println("SENSOR ACTIVE");
  delay(50);

  // give the Ethernet shield a second to initialize:
  delay(1000);
}

void loop()
{
  // if there are incoming bytes available
  if (client.available()) {
    char c = client.read();
    Serial.print(c);
  }
  int stat=0;
  //check if any event has taken place
  if(digitalRead(pirEntryPin) == HIGH || digitalRead(pirExitPin) == HIGH){
    if(digitalRead(pirEntryPin) == HIGH && digitalRead(pirExitPin) == LOW){
      stat = 1;
    }
    else if(digitalRead(pirEntryPin) == LOW && digitalRead(pirExitPin) == HIGH){
      stat = -1;
    }
    else{
      stat = 0;
    }
    httpPutRequest(stat);
  }
  //It has been more than the minimum time since the last update to LED Data 
  if (millis() - lastConnectionTime > postingInterval) {
    httpGetRequest();
    lastConnectionTime = millis();
  }
}
void httpPutRequest(int stat){
  if (client.connect(server, 443)) {
    Serial.println("connected");
    // Make a HTTP PUT request:
    client.println("PUT //1/classes/GameScore/Ed1nuqPvcm HTTP/1.1");
    client.println("Host: api.parse.com");
    client.println("X-Parse-Application-Id: SxjfKcwYdNLljnzzqyaj8e8dkOXDPgeXujU9GqNw");
    client.println("X-Parse-REST-API-Key: JYQahDTyvOhwdzc84t7iVu7W2hqsxA0I9WHbshVM");
    client.println("Connection: close");
    client.println();
  }  
  else {
    // if you didn't get a connection to the server:
    Serial.println("connection failed");
  }
  delay(1000);
}
bool analyze(String data){
  if (data.startsWith("Status:")){
    int pos = 9;
    int num=0;
    while(isdigit(data[pos])){
      num = num*10;
      num += data[pos]-'0';
      pos++;
    }
    setLED(num);
    return true;
  }
  return false;
}

void setLED( int num){
  if(num < 0){ 
    Serial.println("Incorrect pointer to status\n");
  }
  else if(num >0 && num <10){
    digitalWrite(RPin, HIGH);
    digitalWrite(GPin, LOW);
    digitalWrite(BPin, LOW);
  }
  else if(num >= 10 && num <20){
    digitalWrite(RPin, LOW);
    digitalWrite(GPin, HIGH);
    digitalWrite(BPin, LOW);
  }
  else if(num >= 20){
    digitalWrite(RPin, LOW);
    digitalWrite(GPin, LOW);
    digitalWrite(BPin, HIGH);
  }
}
    
void httpGetRequest(){
  if (client.connect(server, 443)) {
    Serial.println("connected for GET Request");
    // Make a HTTP PUT request:
    client.println("GET //1/classes/GameScore/Ed1nuqPvcm HTTP/1.1");
    client.println("Host: api.parse.com");
    client.println("X-Parse-Application-Id: SxjfKcwYdNLljnzzqyaj8e8dkOXDPgeXujU9GqNw");
    client.println("X-Parse-REST-API-Key: JYQahDTyvOhwdzc84t7iVu7W2hqsxA0I9WHbshVM");
    client.println("Connection: close");
    client.println();
    }  
    else {
      // if you didn't get a connection to the server:
      Serial.println("connection failed");
    }
    delay(1000); //wait for data to come in
    String data;
    int flag = 0;
    while (client.available()) {
      char c = client.read();
      data += c;
      if(c=='\n'){
        if(analyze(data) == true){
          flag = 1;
          break;
        data = ""; //clear the string
        }
      }
    }
    if(flag == 0){
      Serial.println("No data received for GET Request\n");
    }
}
