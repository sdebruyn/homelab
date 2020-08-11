from sense_hat import SenseHat


def get_measurements():
    sense = SenseHat()
    humidity = sense.get_humidity()
    temperature_humidity = sense.get_temperature_from_humidity()
    temperature_pressure = sense.get_temperature_from_pressure()
    pressure = sense.get_pressure()