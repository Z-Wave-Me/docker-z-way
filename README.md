# Docker container for Z-Way

This Docker container will run the latest [Z-Way](https://z-wave.me/z-way/) - the Smart Home controller software by Z-Wave.Me.

## Getting Started

1. Clone this repository to your local machine:

    ```sh
    git clone https://github.com/Z-Wave-Me/docker-z-way.git
    cd docker-z-way
    ```

2. Check which ports your Z-Wave and Zigbee interfaces are on:

    - **Linux**:

        ```sh
        ls /dev/tty*
        ```

    - **Windows** (using PowerShell):

        ```powershell
        Get-WmiObject Win32_SerialPort
        ```

    - **macOS**:

        ```sh
        ls /dev/cua*
        ```

3. Update the `docker-compose.yml` file with the correct device paths if necessary.

4. Build and start the container:

    ```sh
    docker compose build
    docker compose up
    ```

This server works only with controllers from Z-Wave.Me, such as RaZberry 2/5/7/[Pro](https://z-wave.me/products/razberry/), [mPCIe module](https://z-wave.me/products/mpcie/), UZB, and [Z-Station](https://z-wave.me/products/z-station/).

## Running on Raspberry Pi

On Raspberry Pi, build the docker container:

    ```sh
    sudo apt-get install git
    git clone https://github.com/Z-Wave-Me/docker-z-way
    sudo docker build -t z-way-container .
    sudo mkdir /data
    ```

Run the container:

    ```sh
    sudo docker run -p 8083 -v /data:/data --device /dev/ttyUSB0:/dev/ttyUSB0 -it z-way-container /opt/z-way-server/run.sh
    ```

Change `/dev/ttyUSB0` to `/dev/ttyAMA0` in the line above and in `Apps > Active Apps > Z-Wave Network Access > Serial port` if you are using RaZberry 7 Pro or other board connected to Raspberry Pi UART pins.

All your files will be stored in the /data folder of your host.
