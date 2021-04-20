# Floatr Pal

This is the companion piece to [Floatr][floatr_github_link].  It receives, decodes, converts and persists [AIS messages][ais_wiki_link] received with your [SDR][sdr_link].

## Requirements

* An antenna and SDR
* [nmea_plus][nmea_plus_link]
* [rtl_ais][rtl_ais_link]

## Installation

In order for Floatr to work correctly, two services must run (I use systemd):

* `decode-ais.sh` uses your SDR to turn radio signals into [AIVDM sentences][aivdm_link] with rtl_ais
* `log-ais.sh` parses these sentences with nmea_plus and saves them to the database

You'll need to replace the following placeholders throughout:

* `RAILS_APPLICATION_PATH` - path to the Floatr application
* `DECODER_PATH` - path to rtl_ais
* `FLOATR_SERVICE_PATH` - path to ais.rb (i.e. `/usr/local/share/floatr/`)
* `RBENV_PATH` - i.e. `/home/username/.rbenv/shims/ruby`

Ideally, the services work like this:

* Your antenna receives AIS messages...
* That are decoded into AIVDM sentences by `decode-ais.sh`...
* And echoed to port 4159.
* The output of this port is then piped into `log-ais.sh`...
* Where it's parsed into Active Record objects by `ais.rb`...
* And saved to the database for the Rails application to consume.

[floatr_github_link]: https://github.com/ryansprott/floatr
[ais_wiki_link]: https://en.wikipedia.org/wiki/Automatic_identification_system
[sdr_link]: https://www.rtl-sdr.com/
[nmea_plus_link]: https://github.com/ianfixes/nmea_plus
[rtl_ais_link]: https://github.com/dgiardini/rtl-ais
[aivdm_link]: https://gpsd.gitlab.io/gpsd/AIVDM.html
