global with sharing class WeatherModel 
{
    global String city  { get; set; }
    global Decimal temp { get; set; }

    global WeatherModel(String city, Decimal temp) 
    {
        this.city = city;
        this.temp = temp;
    }

}