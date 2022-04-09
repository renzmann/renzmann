#!/usr/bin/env bash
flash-model-f() {
	if [[ ! -z $(sudo dfu-programmer atmega32u2 get manufacturer) ]]; then
		sudo dfu-programmer atmega32u2 erase
		sudo dfu-programmer atmega32u2 flash ${1:-xwhatsit_brand_new_model_f_f77_wcass_renzmann_modelf_77.hex}
	fi
}
