#import "UIKitUtils.h"

#import <objc/runtime.h>

@interface CustomBlurEffect : UIBlurEffect

/*@property (nonatomic) double blurRadius;
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
@property (nonatomic) double zoom;*/

+ (id)effectWithStyle:(long long)arg1;

@end

static NSString *encodeText(NSString *string, int key) {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    for (int i = 0; i < (int)[string length]; i++) {
        unichar c = [string characterAtIndex:i];
        c += key;
        [result appendString:[NSString stringWithCharacters:&c length:1]];
    }
    return result;
}

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

static void setNilField(CustomBlurEffect *object, NSString *name) {
    SEL selector = NSSelectorFromString(name);
    NSMethodSignature *signature = [[object class] instanceMethodSignatureForSelector:selector];
    if (signature == nil) {
        return;
    }
    
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:signature];
    [inv setSelector:selector];
    id value = nil;
    [inv setArgument:&value atIndex:2];
    [inv setTarget:object];
    [inv invoke];
}

static void setBoolField(CustomBlurEffect *object, NSString *name, BOOL value) {
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


UIBlurEffect *makeCustomZoomBlurEffectWithRadius(double blurRadius) {
    if (@available(iOS 11.0, *)) {
        NSString *string = [@[@"_", @"UI", @"Custom", @"BlurEffect"] componentsJoinedByString:@""];
        CustomBlurEffect *result = (CustomBlurEffect *)[NSClassFromString(string) effectWithStyle:0];
        
        setField(result, encodeText(@"tfuCmvsSbejvt;", -1), blurRadius);
        //setField(result, encodeText(@"tfu[ppn;", -1), 0.015);
        setNilField(result, encodeText(@"tfuDpmpsUjou;", -1));
        setField(result, encodeText(@"tfuDpmpsUjouBmqib;", -1), 0.0);
        setField(result, encodeText(@"tfuEbslfojohUjouBmqib;", -1), 0.0);
        setField(result, encodeText(@"tfuHsbztdbmfUjouBmqib;", -1), 0.0);
        setField(result, encodeText(@"tfuTbuvsbujpoEfmubGbdups;", -1), 1.0);
        
        if ([UIScreen mainScreen].scale > 2.5f) {
            setField(result, encodeText(@"setScale:", 0), 0.3);
        } else {
            setField(result, encodeText(@"setScale:", 0), 0.5);
        }
        return result;
    } else {
        return [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    }
}


UIBlurEffect *makeCustomZoomBlurEffect(void) {
    return makeCustomZoomBlurEffectWithRadius(10.0);
}
