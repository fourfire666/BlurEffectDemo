# BlurEffectDemo
## 说在前面
前段时间项目中用到了模糊效果，我发现系统提供的UIBlurEffect模糊效果不能调整参数。在网上也看了很多大佬的文章，其中大部分都是传入一张图片，再将图片模糊处理后返回。这种方式可以调整模糊半径，满足我的展示需求，但是在横竖屏切换时体验较差，而且占用CPU资源比较严重。

偶然间发现了Telegram上模糊效果就是我想要的，恰好她又是开源的，于是就有下面的内容。此Demo提供了OC和Swift两个版本，希望能帮到你。


## UIVisualEffectView
[UIVisualEffectView](https://developer.apple.com/documentation/uikit/uivisualeffectview)是用来实现一些复杂视觉效果的对象。下面例举了三个使用示例，UICustomBlurEffect是重点。
* UIVisualEffectView + UIBlurEffect （基础模糊效果）
* UIVisualEffectView + UIVibrancyEffect （有活力的模糊效果） 
* **UIVisualEffectView + UICustomBlurEffect （自定义模糊效果）**


## UIVisualEffectView + UIBlurEffect
### 效果图
![blurEffect](https://github.com/fourfire666/BlurEffectDemo/blob/master/%E6%95%88%E6%9E%9C%E5%9B%BE/blurEffect.jpg)

### 介绍
[UIBlurEffect](https://developer.apple.com/documentation/uikit/uiblureffect)用于实现基础的模糊效果。

### 用法
```
let effectView = UIVisualEffectView.init(frame: view.frame)
effectView.effect = UIBlurEffect.init(style: .dark)
view.addSubview(effectView)
```


## UIVisualEffectView + UIVibrancyEffect
### 效果图
 ![vibrancyEffect2](https://github.com/fourfire666/BlurEffectDemo/blob/master/%E6%95%88%E6%9E%9C%E5%9B%BE/vibrancyEffect2.jpg)


### 介绍
[UIVibrancyEffect](https://developer.apple.com/documentation/uikit/uivibrancyeffect)用于放大和调整位于视觉效果视图后面的内容的颜色。iPhone输入密码界面就使用了该效果（图右）。

### 用法
```
//底部模糊效果
let effectView = UIVisualEffectView.init(frame: view.frame)
effectView.effect = UIBlurEffect.init(style: .dark)
view.addSubview(effectView)

//充满活力的模糊效果，会放大底部的模糊效果的颜色
let vibrancyEffectView = UIVisualEffectView.init(frame: .init(x: 100, y: 100, width: 50, height: 50))
view.addSubview(vibrancyEffectView)

let imageView = UIImageView.init(frame: .init(x: 0, y: 0, width: 50, height: 50))
imageView.image = UIImage.init(named: "Frog.jpg")?.withRenderingMode(.alwaysTemplate)
vibrancyEffectView.contentView.addSubview(imageView)
```


## UIVisualEffectView + UICustomBlurEffect （重点）
### 效果图
![CustomBlurEffect-w300](https://github.com/fourfire666/BlurEffectDemo/blob/master/%E6%95%88%E6%9E%9C%E5%9B%BE/CustomBlurEffect.gif)


### 介绍
UIBlurEffect内置的几个模糊效果往往不能满足我们的开发需求，要想实现自定义的模糊效果，就要用到私有类UICustomBlurEffect，核心代码来自开源项目[Telegram-iOS](https://github.com/TelegramMessenger/Telegram-iOS)。

源码的抗审查也做的非常好，对关键信息进行了转码，用[NSInvocation](https://developer.apple.com/documentation/foundation/nsinvocation)类实现了修改对象的属性。

```
static void setField(CustomBlurEffect *object, NSString *name, double value) {
    SEL selector = NSSelectorFromString(name);
    NSMethodSignature *signature = [[object class] instanceMethodSignatureForSelector:selector];
    if (signature == nil) {
        return;
    }
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:signature];
    [inv setSelector:selector];
    [inv setArgument:&value atIndex:2];
    [inv setTarget:object];
    [inv invoke];
}
```

你可以按照示例的方式，修改UICustomBlurEffect的所有属性。
```
@property (nonatomic) double blurRadius;
@property (nonatomic) double colorBurnTintAlpha;
@property (nonatomic) double colorBurnTintLevel;
@property (nonatomic, retain) UIColor *colorTint;
@property (nonatomic) double colorTintAlpha;
@property (nonatomic) bool darkenWithSourceOver;
@property (nonatomic) double darkeningTintAlpha;
@property (nonatomic) double darkeningTintHue;
@property (nonatomic) double darkeningTintSaturation;
@property (nonatomic) double grayscaleTintAlpha;
@property (nonatomic) double grayscaleTintLevel;
@property (nonatomic) bool lightenGrayscaleWithSourceOver;
@property (nonatomic) double saturationDeltaFactor;
@property (nonatomic) double scale;
@property (nonatomic) double zoom;
```

### 用法
```
let effectView = UIVisualEffectView.init(frame: view.frame)
effectView.effect = makeCustomZoomBlurEffect()
view.addSubview(effectView)
```



## 说在后面
特别注意，UICustomBlurEffect在iOS14上将无法使用，后续有好的解决方案我也会及时补充更新。本文只是大概说了下UIVisualEffectView的用法，具体细节还请参考[官方文档](https://developer.apple.com/documentation/uikit/uivisualeffectview)。
