#!/bin/bash

set -e

chown -R www-data: /var/sig/tiles
apache2ctl -DFOREGROUND
