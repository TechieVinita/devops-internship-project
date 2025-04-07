from flask import Flask
import time
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World from Vinita Deora!"

@app.route("/compute")
def compute():
    def fib(n):
        a, b = 0, 1
        for _ in range(n):
            a, b = b, a + b
        return a
    fib(10000)
    return "Done"
