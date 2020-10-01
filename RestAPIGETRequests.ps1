#Convert JSON to PowerShellPipeline

Function Get-Weather($location)
{
$url = "http://api.weatherapi.com/v1/current.json?key=8ec40ca2e0114558af2164545202809&q=($location)"
$response = Invoke-RestMethod -Uri $url -Method Get -ResponseHeadersVariable r -StatusCodeVariable s 
    if($s -eq 200){
    $response.current | Format-Table *
    }
    else{
    $r
    }
} #End Function Get-Weather
##########################################
#Get-Weather Olympia, WA
##########################################

###Get Location Data Function###
Function Get-Location($location)
{
    $url = "http://api.weatherapi.com/v1/current.json?key=8ec40ca2e0114558af2164545202809&q=($location)"
    $response = Invoke-RestMethod -Uri $url -Method Get -ResponseHeadersVariable r -StatusCodeVariable s
    if ($s -eq 200) {
        $response.location | Format-Table *
    }
    else{
    $r
    }
} #End FunctionGet-Location
##########################################
#Get-Location Olympia, WA
##########################################

###Get Temperature in Fahrenheit###
Function Get-WeatherFahrenheit($location)
{
$url = "http://api.weatherapi.com/v1/current.json?key=8ec40ca2e0114558af2164545202809&q=($location)"
$response = Invoke-RestMethod -Uri $url -Method Get -ResponseHeadersVariable r -StatusCodeVariable s 
    if($s -eq 200){
    $response.current.temp_f | ConvertFrom-Json | Format-Table *
    }
    else{
    $r
    }
} 

#End Function Get-WeatherFahrenheit
##########################################
#Get-WeatherFahrenheit Olympia, WA
##########################################

###Get Temperature in Celsius###
Function Get-WeatherCelsius($location,$days)
{
$url = "http://api.weatherapi.com/v1/current.json?key=8ec40ca2e0114558af2164545202809&q=($location)"
$response = Invoke-RestMethod -Uri $url -Method Get -ResponseHeadersVariable r -StatusCodeVariable s 
    if($s -eq 200){
    $response.current.temp_c | Format-Table *
    }
    else{
    $r
    }
} #End Function Get-WeatherCelsius
##########################################
#Get-WeatherCelsius Olympia, WA
##########################################

###Get Weather Forecast###
Function Get-WeatherForecast($location,$numberDays)
{

    $url = "http://api.weatherapi.com/v1/forecast.json?key=8ec40ca2e0114558af2164545202809&q=($location)&days=7"

$response = Invoke-RestMethod -Uri $url -Method Get -ResponseHeadersVariable r -StatusCodeVariable s 
        
foreach ($i in $response){
    if($s -eq 200){
    $response.forecast.forecastday | Format-List Date
    }
    else{
    $r
    }

$response2 = Invoke-RestMethod -Uri $url -Method Get -ResponseHeadersVariable r -StatusCodeVariable s 
    if($s -eq 200){
    $response2.forecast.forecastday.day | Format-List maxtemp_f, mintemp_f, daily_chance_of_rain
    }
    else{
    $r
    }

$response3 = Invoke-RestMethod -Uri $url -Method Get -ResponseHeadersVariable r -StatusCodeVariable s 
    if($s -eq 200){
    $response3.forecast.forecastday.day.condition | Format-Table -Property * -AutoSize
    }
    else{
    $r
    } 
    Write-Host | Format-Table *   
  } 
} 
 #End Function Get-WeatherForecast
##########################################
Get-WeatherForecast -location 98501
##########################################


###Translate City to Zip Code###
Function Resolve-Zipcode
{
    Param($city,$state)
$url2 = "https://us-zipcode.api.smartystreets.com/lookup?auth-id=31fbfed0-12a5-4752-5082-c09b39201341&auth-token=uSYeVPUv95bYaUoPEUZn&city=($city)&state=($state)"
$response = Invoke-RestMethod -Uri $url2 -Method Get -ResponseHeadersVariable r -StatusCodeVariable s 
    if($s -eq 200){
    $response.zipcodes | Out-GridView -Verbose
    }
    else{
    $r
    }
} #End Function Resolve-Zipcode
##########################################
#Resolve-Zipcode -city Olympia -state WA
##########################################
