# SDK for IOS #

本项目是 **中移物联网公司** 为方便IOS开发者接入 **设备云** 平台而开发的SDK。关于设备云请进入[**设备云主站**](http://open.iot.10086.cn)了解详情。如果要了解OneNet API请进入 [**开发者中心**](http://open.iot.10086.cn/develop/doc/api/restfullist "开发者中心") 参考**API文档**。

## 屏幕截图 ##

![screenshot2](/img/4.png)
![screenshot3](/img/3.png)

## 说明 ##

OneNetApi的网络请求框架使用的是[**ASIHTTPRequest**]，如果要以源码的形式使用，请首先下载ASIHTTPRequest到相关工程

- 将 **SDK.h SDK.m** 两个文件添加到相关项目



## 如何使用 ##

### 示例 ###

所有的请求都是通过`SDK.h` 里面的方法完成，返回结果以JSON形式返回给用户，以获取添加设备为例

    // 所有请求中用到的RequestKey都是调用login接口返回的
  
   -RequestParam参数形如 @"{\"title\":\"test\"}"
   NSDictionary *dict=[[SDK share] getMoreDeviceRequestKey:@"<填入你的APIKEY>" andRequestParam:@"<填入你自己的参数>"];
   
