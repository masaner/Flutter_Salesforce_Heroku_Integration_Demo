---
layout: default
title: Weather Model
parent: Getting Weather Data
grand_parent: Apex Code
permalink: /docs/apex-code/weatherdata/model/
---

# WeatherModel.cls
{: .no_toc }

```java
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
```
