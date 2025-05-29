# README

## Overview
This project involves working with STM32 microcontrollers and includes modifications to the linker script to support different flash memory origins. The linker script is updated with conditional compilation directives (`#ifdef`) and saved with a `.ld.S` extension to allow for preprocessing.

## Instructions

1. **Modify the Linker Script**:
    - Update the linker script to include `#ifdef` directives for handling different flash memory origins.
    - Save the modified linker script with a `.ld.S` extension to enable preprocessing.

2. **Using `makeAppB.sh`**:
    - The `makeAppB.sh` script is used to automate the build process for the application.
    - Ensure that the script is configured correctly to handle the modified linker script and any specific build requirements.

3. **Building the Application**:
    - the `makeAppB.sh` script to postbuild process.
    - Verify that the build process completes successfully and that the output binaries are generated as expected.

4. **Flashing the Microcontroller**:
    - Use the blhost tool to flash the generated binary/binaries onto the STM32 microcontroller.
    - Ensure that the correct flash origin is used during the flashing process.

5. **Testing**:
    - Test the application on the microcontroller to ensure it functions as intended.
    - Debug and resolve any issues that arise during testing.

## Notes
- The `.ld.S` extension allows the linker script to be preprocessed, enabling the use of conditional compilation.
- Refer to the STM32 documentation for additional details on linker scripts and memory configuration.

## References
- STM32 Documentation
- `makeAppB.sh` script for post build, creating the binaries, and combine them.
