#!/usr/bin/env python3

# pip install git+https://github.com/almottier/TapoP100.git@main

import sys
import argparse
import time
import os
from PyP100 import PyP110

my_parser = argparse.ArgumentParser(description='Controls p110 plugs')

my_parser.add_argument(
    '-p',
    '--plug',
    default='garage',
    metavar='plug',
    help='the plug which control'
)
my_parser.add_argument(
    '-c',
    '--command',
    default='info',
    help='the command to execute'
)

my_parser.add_argument(
    '-e',
    '--energy',
    default='4000',
    metavar='energy',
    type=int,
    help='the max energy to charge'
)

my_parser.add_argument(
    '-i',
    '--interval',
    default='5',
    metavar='interval',
    type=int,
    help='the print interval in sec '
)

args = my_parser.parse_args()

print(vars(args))

user = os.environ["KASA_USER"]
pwd = os.environ["KASA_PWD"]

if args.plug == 'garage':
    # MAC: b0:a7:b9:0f:83:5c
    p110 = PyP110.P110("192.168.0.51", user, pwd)
else:
    # MAC: 54:af:97:32:c2:cb
    p110 = PyP110.P110("192.168.0.58", user, pwd)

p110.handshake()
p110.login()

if args.command == 'energy':
    print(p110.getEnergyUsage())

if args.command == 'info':
    print(p110.getDeviceInfo())

if args.command == 'on':
    p110.turnOn()
    info = p110.getDeviceInfo()
    print("On" if info['device_on'] else "Off")

if args.command == 'off':
    p110.turnOff()
    info = p110.getDeviceInfo()
    print("On" if info['device_on'] else "Off")

if args.command == 'charge':
    p110.turnOn()
    energy = p110.getEnergyUsage()
    startEnergy = energy['result']['today_energy']
    charged = 0
    timeElapsed = 0
    while charged < args.energy:
        print(charged)
        energy = p110.getEnergyUsage()
        currentEnergy = energy['result']['today_energy']
        charged = currentEnergy - startEnergy
        time.sleep( args.interval )
