from setuptools import setup

setup(
    name="sensors",
    version="0.1",
    py_modules=['sensors'],
    entry_points={
        'console_scripts': ['send-measurement-azure=sensors:send_measurements'],
    },
    install_requires=['sense-hat', 'azure-eventhub', 'utcdatetime', 'Click']
)
