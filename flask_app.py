from flask import Flask, request, jsonify
from ast import literal_eval
from backend import freq

app = Flask(__name__)


@app.route('/', methods=['POST'])
def index():
    some_json = request.get_json()
    acc = some_json['acc']
    acc = literal_eval(acc)
    print(acc)
    maxFrequency = freq(acc)
    return jsonify({'maxFrequency':str(maxFrequency)})


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)