Cached translations of timezones for js

Install
=======

    gem install js-cldr-timezones

Usage
=====

This project supports over 573 languages.
We provide a file with a hash that has the translations. 
In the html header translations you should add:
    
    <%= javascript_include_tag "js_cldr/#{locale}_cldr_timezones" %>

```locale``` is a bcp-47 language tag. However the dash is substituted by an underscore to make it. For example:

    <%= javascript_include_tag "js_cldr/es_cldr_timezones" %>

    <%= javascript_include_tag "js_cldr/ja_cldr_timezones" %>

    <%= javascript_include_tag "js_cldr/es_MX_cldr_timezones" %>

This provides access to a hash that has the name in the following format:

    "#{locale}_cldr_timezones_hash"

The hash contains a meaninful subset of 124 timezones. It has the timezone indentifier as the key and the translation as the value.

Examples: 
    
    es_cldr_timezones_hash["Europe/Moscow"] # "(GMT+04:00) Moscú"

    ja_cldr_timezones_hash["America/Cordoba"] # "（GMT-09:00）モスクワ"

There is also support for fallback.

    es_MX_cldr_timezones_hash["Europe/Moscow"] # "(GMT+04:00) Moscú"

Development
=====

Translations are already included in the project and you don't need to generate them.
However if you want to fork this project and generate your own translations you should simply run:

    rake generate_timezones

This project uses ```ruby-cldr-timezones``` to generate the javascript for each language.


TODO
=====

- Support for option :all which will provide the complete set of timezones that are supported by ```ruby-cldr-timezones```

Author
======
[Ana Martinez](https://github.com/anamartinez)<br/>
acemacu@gmail.com<br/>
License: MIT<br/>

[![Build Status](https://travis-ci.org/anamartinez/js-cldr-timezones.png)](https://travis-ci.org/anamartinez/js-cldr-timezones)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/anamartinez/js-cldr-timezones))
