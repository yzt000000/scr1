#!/bin/bash

declare -i int=1

while ((int == 1)) 
do
    grep ': 00000cf4 ...' ./build/trace_mprf_0.log  |wc
    sleep 1
done
