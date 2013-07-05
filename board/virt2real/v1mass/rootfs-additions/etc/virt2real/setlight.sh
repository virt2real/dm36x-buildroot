#!/bin/sh

mount -t debugfs none /sys/kernel/debug

echo 73 > /sys/class/gpio/export
echo 74 > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio73/direction
echo "out" > /sys/class/gpio/gpio74/direction


case "$1" in
blue)
	echo "Set light blue"
	echo 0 > /sys/class/gpio/gpio73/value
	echo 0 > /sys/class/gpio/gpio74/value
	;;
white)
	echo "Set light white"
	echo 1 > /sys/class/gpio/gpio73/value
	echo 1 > /sys/class/gpio/gpio74/value
	;;
lightblue)
	echo "Set light lightblue"
	echo 1 > /sys/class/gpio/gpio73/value
	echo 0 > /sys/class/gpio/gpio74/value
	;;
magenta)
	echo "Set light magenta"
	echo 0 > /sys/class/gpio/gpio73/value
	echo 1 > /sys/class/gpio/gpio74/value
	;;
esac

echo 73 > /sys/class/gpio/unexport
echo 74 > /sys/class/gpio/unexport
