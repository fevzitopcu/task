from flask import Flask
import json

with open('data.json') as json_file:
    data = json.load(json_file)

app = Flask(__name__)

@app.route("/")
def hello():

    return (data)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
