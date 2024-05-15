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
        ls /dev/tty.*
        ```

3. Update the `docker-compose.yml` file with the correct device paths if necessary.

4. Build and start the container:

    ```sh
    docker-compose build
    docker-compose up
    ```

This server works only with controllers from Z-Wave.Me, such as RaZberry 2/5/7/Pro, mPCI module, UZB, and Z-Station.