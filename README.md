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
