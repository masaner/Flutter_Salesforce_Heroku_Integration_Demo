@RestResource(urlMapping='/Weather/*')
global with sharing class WeatherClient 
{
    // @HttpPost
    // global static WeatherData getWeather(WeatherRequest req) 
    // {
    //     WeatherData wd = getWeather(req.lon, req.lat);
    //     return wd;
    // }

    @HttpPost
    global static WeatherData getWeather(String lat, String lon)
    {   
        Open_Weather__c ow = Open_Weather__c.getInstance(); 
        String apiKey = ow.API_KEY__c;
        String url = 'https://api.openweathermap.org/data/2.5/weather?lat='+lat+'&lon='+lon+'&units=metric&appid='+apiKey;

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        
        String jsonBody = res.getBody();

        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(jsonBody);
        String name = (String) m.get('name');
        Map<String, Object> main = (Map<String, Object>)m.get('main');
        Decimal temp = (Decimal) main.get('temp');

        WeatherData data = new WeatherData(name,temp);
        return data;
    }

    global class WeatherRequest 
    {
        global String lon { get; set; }
        global String lat { get; set; }
    }

}