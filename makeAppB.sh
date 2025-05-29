#!/bin/bash

PROJ_DIR=$1
BASE_NAME=$2

BASE_NAME=${BASE_NAME%_A}

OBJ_DIR="${PROJ_DIR}/Debug"
LINKER="${PROJ_DIR}/STM32G030C8TX_FLASH.ld.S"
APP_B_ELF="${OBJ_DIR}/${BASE_NAME}_B.elf"
APP_A_BIN="${OBJ_DIR}/${BASE_NAME}_A.bin"
APP_B_BIN="${OBJ_DIR}/${BASE_NAME}_B.bin"
MAP_FILE="${OBJ_DIR}/${BASE_NAME}_B.map"
OUT="${OBJ_DIR}/dual_firmware.pkg"

# generate new linker script for app B
arm-none-eabi-gcc -E -x c -P -DAPP_B $LINKER -o ${PROJ_DIR}/STM32G030C8TX_FLASH_B.ld

LINKER="${PROJ_DIR}/STM32G030C8TX_FLASH_B.ld"

# Re-link with -DAPP_B
arm-none-eabi-gcc -mcpu=cortex-m0plus -mthumb \
  -T"$LINKER" \
  -DAPP_B \
  -Wl,-Map="$MAP_FILE" \
  -Wl,--gc-sections -static --specs=nosys.specs --specs=nano.specs -mfloat-abi=soft \
  -o "$APP_B_ELF" \
   @"$OBJ_DIR/objects.list" \
  -Wl,--start-group -lc -lm -Wl,--end-group

# Generate binary
arm-none-eabi-objcopy -O binary "$APP_B_ELF" "$APP_B_BIN"

# Exit if any of the binaies does not exist.
[ -f "$APP_A_BIN" ] || { echo "Missing A"; exit 1; }
[ -f "$APP_B_BIN" ] || { echo "Missing B"; exit 1; }

# Get the size of each bin
SIZE_A=$(stat -c%s "$APP_A_BIN")
SIZE_B=$(stat -c%s "$APP_B_BIN")

# genetate the output package
printf "APP_A##%s##" "$SIZE_A" > "$OUT"
cat "$APP_A_BIN" >> "$OUT"

printf "APP_B##%s##" "$SIZE_B" >> "$OUT"
cat "$APP_B_BIN" >> "$OUT"

