Function ConvertTemperature {

    [CmdletBinding()]
    param (
        $temp = (read-host -prompt 'What temperature (number only, no units)'),
        [string]$unit = (read-host -prompt 'What unit? (C, F, or K)')
    )
     
    if ($unit -eq "C") {
        $celcius = "$temp"
        $fahrenheit = "$((1.8 * $temp) + 32 )"
        $kelvin = "$($temp + 273.15)"
    }

    elseif ($unit -eq "F") {
        $celcius = "$( (($temp - 32)/9)*5 )"
        $fahrenheit = "$temp"
        $kelvin = "$(((($temp - 32) * 5 ) / 9 ) + 273.15)"
    }
    
    else {
        $celcius = "$($temp - 273.15)"
        $fahrenheit = "$((($temp -273.15) * 1.8 ) + 32 )"
        $kelvin = "$temp"
    }
    
    $table = [PSCustomObject]@{
        Celcius    = [math]::Round($celcius,2)
        Fahrenheit = [math]::Round($fahrenheit,2)
        Kelvin     = [math]::Round($kelvin,2)
    }
    
    $table | Format-Table -Property Celcius, Fahrenheit, Kelvin -AutoSize

}#end ConvertTemperature