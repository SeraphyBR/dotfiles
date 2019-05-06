#!/bin/sh
uptime --pretty | sed 's/up //; s/\ days\?,/d/; s/\ hours\?,\?/h/; s/\ minutes\?/m/'
