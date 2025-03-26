#!/bin/bash

cp /custom_overlays/mac/* /usr/local/lib/python2.7/site-packages/volatility-2.6.1-py2.7.egg/volatility/plugins/overlays/mac/ &> /dev/null
cp /custom_overlays/linux/* /usr/local/lib/python2.7/site-packages/volatility-2.6.1-py2.7.egg/volatility/plugins/overlays/linux/ &> /dev/null
cp /custom_overlays/windows/* /usr/local/lib/python2.7/site-packages/volatility-2.6.1-py2.7.egg/volatility/plugins/overlays/windows/ &> /dev/null

sudo -u finder /bin/bash