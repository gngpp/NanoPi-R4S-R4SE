#!/bin/bash
PROJECTROOT=$(pwd)
pushd openwrt
OPENWRTROOT=$(pwd)
pushd $OPENWRTROOT/bin/packages/*
PLATFORM=$(basename `pwd`)
echo "PLATFORM=$PLATFORM"
pushd $OPENWRTROOT/bin/targets/*
TARGET=$(basename `pwd`)
echo "TARGET=$TARGET"
pushd *
SUBTARGET=$(basename `pwd`)
echo "SUBTARGET=$SUBTARGET"

pushd $PROJECTROOT/configs/opkg
        sed -i "s/subtarget/$SUBTARGET/g" distfeeds*.conf
        sed -i "s/target\//$TARGET\//g" distfeeds*.conf
        sed -i "s/platform/$PLATFORM/g" distfeeds*.conf