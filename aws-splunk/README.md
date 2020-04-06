# Splunk

## Getting data into this instance

### Configuring the HTTP Event Collector
* https://docs.splunk.com/Documentation/Splunk/8.0.3/Data/UsetheHTTPEventCollector#Configure_HTTP_Event_Collector_on_Splunk_Enterprise
* We don't need to change the default port of `8088` but we do need to uncheck "Enable SSL" in the settings.
* Externally, however, our reverse proxy will expose this on standard HTTPS `443` with a valid LetsEncrypt cert.
* Things are working properly if https://splunk.darkwebkittens.xyz in a browser displays "Not Found" instead of "Bad Gateway".