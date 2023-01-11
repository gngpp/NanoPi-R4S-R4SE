#!/bin/bash

# initialize the fan speed value
if [ ! -d /sys/class/pwm/pwmchip1 ]; then
  logger -t "fa-rk3399-pwmfan[$$]" "this model does not support pwm."
  exit 1
fi

if [ ! -d /sys/class/pwm/pwmchip1/pwm0 ]; then
  echo -n 0 > /sys/class/pwm/pwmchip1/export
fi
sleep 1
while [ ! -d /sys/class/pwm/pwmchip1/pwm0 ]; do
  sleep 1
done

ISENABLE=`cat /sys/class/pwm/pwmchip1/pwm0/enable`

if [ $ISENABLE -eq 1 ]; then
  echo -n 0 > /sys/class/pwm/pwmchip1/pwm0/enable
fi

echo -n 50000 > /sys/class/pwm/pwmchip1/pwm0/period
echo -n 1 > /sys/class/pwm/pwmchip1/pwm0/enable

# max speed run 5s
echo -n 46990 > /sys/class/pwm/pwmchip1/pwm0/duty_cycle
sleep 5
echo -n 25000 > /sys/class/pwm/pwmchip1/pwm0/duty_cycle

# 5 gears fan speed
declare -a Percents=(100 80 60 40 20)
# cpu temperature series
declare -a CpuTemps=(56000 53000 48000 42000 36000)
# fan speed series
declare -a PwmDutyCycles=(1000 2000 3000 4000 5000)

# default fan is stopped
DefaultDuty=49990
DefaultPercents=0

while true; do
    # get cpu temperature
    temp=$(cat /sys/class/thermal/thermal_zone0/temp)
    # initialize default value
    INDEX=0
    FOUNDTEMP=0
    DUTY=$DefaultDuty
    PERCENT=$DefaultPercents

    # pairing of temperature and speed
    for i in 0 1 2 3 4; do
        if [ $temp -gt ${CpuTemps[$i]} ]; then
            INDEX=$i
            FOUNDTEMP=1
            break
        fi
    done

    # turn on fan rotation
    if [ ${FOUNDTEMP} == 1 ]; then
        DUTY=${PwmDutyCycles[$i]}
        PERCENT=${Percents[$i]}
    fi

    # override value for fan speed
    echo $DUTY > /sys/class/pwm/pwmchip1/pwm0/duty_cycle;

    logger -t "fa-rk3399-pwmfan[$$]" "temp: $temp, duty: $DUTY, ${PERCENT}%"

    # heartbeat
    sleep 300s;
done