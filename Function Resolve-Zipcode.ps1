Function Resolve-Zipcode{

    param(
       [Parameter(Mandatory = $true, HelpMessage="Enter a city!")]
       [ValidateNotNullOrEmpty()]
       [string] $city,

       [Parameter(Mandatory = $true, HelpMessage="Enter a state!")]
       [ValidateNotNullOrEmpty()]
       [string] $state
        
    )
$url2 = "https://us-zipcode.api.smartystreets.com/lookup?auth-id=31fbfed0-12a5-4752-5082-c09b39201341&auth-token=uSYeVPUv95bYaUoPEUZn&city=($city)&state=($state)"
$response = Invoke-RestMethod -Uri $url2 -Method Get -ResponseHeadersVariable r -StatusCodeVariable s 
    if($s -eq 200){
    $response.zipcodes | Format-Table *
    }
    else{
    $r
    }
} #End Function Resolve-Zipcode
##########################################
Resolve-Zipcode
##########################################