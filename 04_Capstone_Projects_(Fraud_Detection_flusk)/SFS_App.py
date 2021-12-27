import numpy as np
import pandas as pd
from flask import Flask, request, jsonify, render_template
import pickle
import sys
import logging

app = Flask(__name__, template_folder='templates')
app.config['EXPLAIN_TEMPLATE_LOADING'] = True
model = pickle.load(open("model.pkl", "rb"))
scaler = pickle.load(open("scaler.pkl", "rb"))


@app.route('/', methods=['GET'])
def Home():
    
    return render_template('index.html')

@app.route('/predict',methods=['POST'])
def predict():
    print('Enter input values')
    my_dict = [float(x) for x in request.form.values()]
    my_dict = pd.DataFrame([my_dict])
    # my_dict = scaler.transform(my_dict)
    result = model.predict(my_dict)
    
    if result > 0.50:
        return render_template('index.html', prediction_text='ATTENTION PLEASE !!!')
    elif result <= 0.50:
        return render_template('index.html', prediction_text='EVERYTHING SEEMS OKAY...')
    else:
        return render_template('index.html', prediction_text='PLEASE ENTER THE CORRECT VALUES IN THE FIELDS TO PREDICT THE FRAUD OF THE TRANSACTION.') 

if __name__ == "__main__":
    app.run(debug=True)

