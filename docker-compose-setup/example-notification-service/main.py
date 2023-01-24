# Example notification service utilizing the twilio API
# Created by Jan Macenka @ 24 Jan 2023

# Config imports
from config import (
    TWILIO_ACCOUNT_SID,
    TWILIO_AUTH_TOKEN,
    TWILIO_FROM_PHONE_NUMBER,
)

# Librarie imports
from flask import Flask, request
from twilio.rest import Client
from twilio.base.exceptions import TwilioRestException

# Generate App-Instance
app = Flask(__name__)

# App Deffinition
MESSAGE_TO_NUMBER = 'message_to_number'
MESSAGE_BODY = 'message_body'
INPUT_FORM = f'''
<h1>Send a SMS via minimal Web-App</h1>
<p>Input some SMS body and recipients-number and hit send:</p>
<form action="/" method="POST">
    <label for="{MESSAGE_TO_NUMBER}">To:</label><br>
    <input name="{MESSAGE_TO_NUMBER}" id="{MESSAGE_TO_NUMBER}" type="text" placeholder="e.g. +491777555111"><br>
    <label for="{MESSAGE_BODY}">Message:</label><br>
    <textarea name="{MESSAGE_BODY}" id="{MESSAGE_BODY}" cols="40" rows="5" placeholder="Enter your message..."></textarea><br>
    <input type="submit" value="send">
</form>
<p>Dont forget to turn off this service after your testing!</p>
'''


@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'GET':
        # On GET-Request check if app can run and return the input form
        if TWILIO_ACCOUNT_SID == "" or TWILIO_AUTH_TOKEN == "" or TWILIO_FROM_PHONE_NUMBER == "":
            return "Please first provide the API Credentials in the config.py file and start again."
        else:
            return INPUT_FORM
    elif request.method == 'POST':
        # On POST-Request extract the data from the form and send SMS via API
        message_to_number = request.form[MESSAGE_TO_NUMBER].strip()
        message_body = request.form[MESSAGE_BODY].strip()
        twilio_client = Client(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
        # Try to send the SMS
        try:
            message = twilio_client.messages.create(
                to=message_to_number,
                from_=TWILIO_FROM_PHONE_NUMBER,
                body=message_body)
            return f"SUCCESS: SMS sent successfully. Message-ID: {message.sid}"
        # On failure, return an error message
        except TwilioRestException as err:
            return f"ERROR: The following error occurred when trying to send the message: {repr(err)}"


# App deployment
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)
