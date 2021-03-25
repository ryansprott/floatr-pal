#!/bin/bash

nc -ul 127.0.0.1 4159 | /RBENV_PATH/.rbenv/shims/ruby /FLOATR_SERVICE_PATH/ais.rb
