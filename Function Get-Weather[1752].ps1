#Chris Panas#     #10/7/2020#      #Visual Studio Code# #PS 7.0#
Function Get-Weather {

    [CmdletBinding()]
    param (
        [string]$location = (read-host -prompt 'What City and State (City, ST)'),
        [string]$numberDays = (Read-Host -Prompt 'How many days (1-3)'),
        [string] $unit = (Read-Host -Prompt 'Input unit C or F')

    )

    #set variable to input desired unit as a table header and object variable (gets around variable type conditioning)
    $maxtemp = "maxtemp_$unit"
    $mintemp = "mintemp_$unit" 

    #set variable for url to pass to API get
    $url = "http://api.weatherapi.com/v1/forecast.json?key=8ec40ca2e0114558af2164545202809&q=$location&days=$numberDays"

    #set response from API to variable
    $response = Invoke-RestMethod -Uri $url -Method Get -ResponseHeadersVariable r -StatusCodeVariable s 

    # utilize ResponseHeaderVariable and StatusCodeVariable to return a Forecast or Error Message in ifelse statement
    
    if ($s -eq 200) {
        #create the $response2 array with a fixed size based on the number of days in the original $response array, which is created when getting the data from the weather API.
        $response2 = new-object -typename 'object[]' -argumentlist $response.forecast.forecastday.date.count

        #loop through each date in $response array, extract the data needed, and assign it to an element of the $response2 array
        for ( $i = 0; $i -lt $response.forecast.forecastday.date.count; $i++ ) {
            $response2[$i] = [pscustomobject]@{Date = $response.forecast.forecastday.date[$i]; "High Temp $unit" = $response.forecast.forecastday.day.$maxtemp[$i]; "Low Temp $unit" = $response.forecast.forecastday.day.$mintemp[$i]; "Chance of rain" = $response.forecast.forecastday.day.daily_chance_of_rain[$i] + "%"; Conditions = $response.forecast.forecastday.day.condition.text[$i] }		
        }
        
        $response2 | format-table -autosize
        $response2 | Format-List -Verbose
        $response2 | Out-GridView -Title "Weather for the next ($numberdays) days in ($location)" #-OutputMode Single
    }
    else {
        $r
    }
}#End Get-Weather Function