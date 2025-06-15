<!DOCTYPE html>
<html>
<head>
  <title>Samsung TV Remote</title>
  <style>
    body { font-family: sans-serif; background-color: #111; color: white; text-align: center; }
    h1 { margin-top: 30px; }
    button {
      font-size: 20px;
      padding: 15px;
      margin: 10px;
      width: 150px;
      background-color: #333;
      color: white;
      border: none;
      border-radius: 10px;
    }
    button:hover {
      background-color: #555;
    }
  </style>
</head>
<body>
  <h1>🎮 Samsung TV Remote</h1>
  <div>
    <button onclick="sendKey('KEY_POWER')">Power</button><br>
    <button onclick="sendKey('KEY_VOLUP')">Volume +</button>
    <button onclick="sendKey('KEY_VOLDOWN')">Volume -</button><br>
    <button onclick="sendKey('KEY_CHUP')">Channel +</button>
    <button onclick="sendKey('KEY_CHDOWN')">Channel -</button><br>
    <button onclick="sendKey('KEY_UP')">↑</button><br>
    <button onclick="sendKey('KEY_LEFT')">←</button>
    <button onclick="sendKey('KEY_ENTER')">OK</button>
    <button onclick="sendKey('KEY_RIGHT')">→</button><br>
    <button onclick="sendKey('KEY_DOWN')">↓</button><br>
    <button onclick="sendKey('KEY_HOME')">Home</button>
    <button onclick="sendKey('KEY_BACK')">Back</button>
  </div>

  <script>
    const TV_IP = "192.168.100.81"; // ✴️ غيّر ده لـ IP التلفزيون بتاعك

    function sendKey(key) {
      fetch(`http://${TV_IP}:8001/api/v2/channels/samsung.remote.control?name=WebRemote`, {
        method: "POST",
        body: JSON.stringify({
          method: "ms.remote.control",
          params: {
            Cmd: "Click",
            DataOfCmd: key,
            Option: false,
            TypeOfRemote: "SendRemoteKey"
          }
        })
      })
      .then(res => console.log(`Sent ${key}`))
      .catch(err => alert("Error: " + err));
    }
  </script>
</body>
</html>
