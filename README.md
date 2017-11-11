# Solcast API shell scripting

[Bash](https://www.gnu.org/software/bash/) & [cURL](https://curl.haxx.se) examples for querying the [Solcast API](https://api.solcast.com.au)

This guide demonstrates using curl and bash for registered users to query the Solcast API [https://api.solcast.com.au](https://api.solcast.com.au).  You will need to register your user account to obtain an API key [https://solcast.com.au/api/register](https://solcast.com.au/api/register/).  Without an API key you will not be able to successfully obtain valid API results.

## Note
It is **recommended** to use a robust client library for programmable use of the API, **but** sometimes a direct approach is useful

### Recommended aliases to add to your `.bash_profile`
``` bash
# Add get-json alias
echo "alias=get-json=\"curl -X GET -H 'Accept: application/json'\"" >> ~/.bash_profile;
# Add get-csv alias
echo "alias=get-csv=\"curl -X GET -H 'Accept: text/csv'\"" >> ~/.bash_profile;
# Update shell
source ~/.bash_profile;
```

### Recommended `environment variables` to add to your `.bash_profile`
``` bash
# Add solcast API url
echo "export SOLCAST_API_URL=https://api.solcast.com.au" >> ~/.bash_profile;
# Add solcast API key
echo "export SOLCAST_API_KEY=YOUR_API_KEY" >> ~/.bash_profile;
# Update shell
source ~/.bash_profile;
```

### Check if your `environment variables` are loaded if not you may need to rerun the command `source ~/.bash_profile` or re-initialize your terminal
``` bash
# Print environment variables
echo "SOLCAST_API_URL = ${SOLCAST_API_URL}";
echo "SOLCAST_API_KEY = ${SOLCAST_API_KEY}";
```

### Session variables for Radiation requests
``` bash
export lat=149.117;
export lng=-35.277;
```

### Put it together and make a Radiation request
``` bash
get-csv "${SOLCAST_API_URL}/radiation/forecasts?longitude=${lat}&latitude=${lng}&api_key=${SOLCAST_API_KEY}"
```

[Sample Result](samples/radiation.csv)

### Sample bash script to read a csv file and get a radiation forecast for each

[Radiation Forecast Script](get-rad-forecasts.sh)

Make the script executable `chmod a+x get-rad-forecasts.sh`

Outputs results to current directory
``` bash
./get-rad-forecasts.sh -i samples/sample_latlngs.csv
```
Specify a results folder directory
``` bash
./get-rad-forecasts.sh -i samples/sample_latlngs.csv -o results
```
