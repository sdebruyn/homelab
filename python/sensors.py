import json

import click
import utcdatetime
from azure.eventhub import EventHubProducerClient, EventData
from sense_hat import SenseHat


def get_measurements_as_eventdata() -> EventData:
    sense = SenseHat()
    humidity = sense.get_humidity()
    temperature_humidity = sense.get_temperature_from_humidity()
    temperature_pressure = sense.get_temperature_from_pressure()
    pressure = sense.get_pressure()
    time = utcdatetime.utcdatetime.now()

    return EventData(json.dumps({
        "humidity": humidity,
        "pressure": pressure,
        "temperature_humidity": temperature_humidity,
        "temperature_pressure": temperature_pressure,
        "measurement_timestamp": str(time)
    }))


@click.command()
@click.argument('conn_str')
@click.argument('name')
def send_measurements(conn_str, eventhub_name):
    if not conn_str:
        click.echo("Connection string is empty")
        exit(1)

    if not eventhub_name:
        click.echo("Event hub name is empty")
        exit(2)

    click.echo("Sending measurements...")
    client = EventHubProducerClient.from_connection_string(conn_str=conn_str, eventhub_name=eventhub_name)
    batch = client.create_batch()
    batch.add(get_measurements_as_eventdata())
    with client:
        client.send_batch(batch)


if __name__ == '__main__':
    send_measurements()
