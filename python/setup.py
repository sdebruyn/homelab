from setuptools import setup, find_packages

setup(
    name="sensors",
    version="0.1",
    packages=find_packages(),
    entry_points={
        'console_scripts': ['send-measurement-azure=sensors:send_measurements'],
    },
    install_requires=['sense-hat', 'azure-eventhub', 'utcdatetime', 'Click']
)
