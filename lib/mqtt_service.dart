import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  late MqttServerClient client;
  Function(bool)? onConnectionChanged;
  Function(String, String)? onMessageReceived;
  Function(String)? onHeartRateUpdated;
  Function(String)? onTemperatureUpdated; // Callback untuk suhu tubuh

  static const String heartRateTopic = 'hospital/heartRate';
  static const String temperatureTopic =
      'hospital/temperature'; // Topik untuk suhu tubuh

  MqttService() {
    client = MqttServerClient('178.128.89.8', 'FlutterClient');
    client.port = 1883;
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.onConnected = _onConnected;
    client.onDisconnected = _onDisconnected;
    client.onSubscribed = _onSubscribed;
  }

  Future<void> connect() async {
    final connMess = mqtt.MqttConnectMessage()
        .withClientIdentifier("FlutterClient")
        .withWillTopic("willtopic")
        .withWillMessage("My will message")
        .startClean()
        .withWillQos(mqtt.MqttQos.atLeastOnce);
    client.connectionMessage = connMess;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == mqtt.MqttConnectionState.connected) {
      print('Connected');
      _notifyConnectionStatus(true);
      client.updates!.listen(_onMessage);
      subscribe(heartRateTopic); // Langganan topik heart rate
      subscribe(temperatureTopic); // Langganan topik suhu tubuh
    } else {
      print('Connection failed');
      client.disconnect();
      _notifyConnectionStatus(false);
      reconnect(); // Coba sambungkan kembali
    }
  }

  void _onMessage(List<mqtt.MqttReceivedMessage<mqtt.MqttMessage>> event) {
    final mqtt.MqttPublishMessage recMess =
        event[0].payload as mqtt.MqttPublishMessage;
    final String message =
        mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    final String topic = event[0].topic;
    print('Received message: $message from topic: $topic');

    if (onMessageReceived != null) {
      onMessageReceived!(topic, message);
    }

    // Cek apakah pesan dari topik suhu tubuh
    if (topic == heartRateTopic && onHeartRateUpdated != null) {
      onHeartRateUpdated!(message);
    } else if (topic == temperatureTopic && onTemperatureUpdated != null) {
      onTemperatureUpdated!(message); // Panggil callback suhu tubuh
    }
  }

  void _notifyConnectionStatus(bool isConnected) {
    if (onConnectionChanged != null) {
      onConnectionChanged!(isConnected);
    }
  }

  void _onConnected() {
    print('MQTT Connected');
    _notifyConnectionStatus(true);
    subscribe(heartRateTopic);
    subscribe(temperatureTopic); // Langganan topik suhu tubuh
  }

  void _onDisconnected() {
    print('MQTT Disconnected');
    _notifyConnectionStatus(false);
    reconnect(); // Coba sambungkan kembali
  }

  void _onSubscribed(String topic) {
    print('Subscribed to $topic');
  }

  void subscribe(String topic) {
    if (client.connectionStatus!.state == mqtt.MqttConnectionState.connected) {
      client.subscribe(topic, mqtt.MqttQos.atLeastOnce);
      print('Subscribed to topic: $topic');
    } else {
      print('Cannot subscribe, not connected');
    }
  }

  void publish(String topic, String message) {
    print('Current connection status: ${client.connectionStatus!.state}');
    if (client.connectionStatus!.state == mqtt.MqttConnectionState.connected) {
      final mqtt.MqttClientPayloadBuilder builder =
          mqtt.MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(topic, mqtt.MqttQos.atLeastOnce, builder.payload!);
      print('Published message: $message to topic: $topic');
    } else {
      print('Cannot publish, not connected');
    }
  }

  void disconnect() {
    client.disconnect();
  }

  // Fungsi untuk mencoba menyambung kembali jika terputus
  void reconnect() async {
    print('Attempting to reconnect...');
    await Future.delayed(Duration(seconds: 5));
    await connect(); // Mencoba kembali menghubungkan
  }
}
