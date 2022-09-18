from flask import Flask, request, jsonify
from ast import literal_eval
from backend import freq
from numpy import abs
import numpy as np

app = Flask(__name__)


@app.route('/', methods=['POST'])
def index():
    some_json = request.get_json()
    acc = some_json['acc']
    acc = literal_eval(acc)
    print(acc)
    xf, yf = freq(acc)
    print(xf)
    print(yf)
    return jsonify({'xf':str(np.round_(xf, decimals = 4)), 'yf':str(np.round_(abs(yf), decimals = 4))})


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)