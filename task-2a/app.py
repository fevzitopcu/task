from flask import Flask
import json
import os

with open('data.json') as json_file:
    data = json.load(json_file)
    data['built_at'] = os.environ.get('IMAGE_TS')

app = Flask(__name__)

@app.route("/")
def hello():

    return (data)

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=80)
