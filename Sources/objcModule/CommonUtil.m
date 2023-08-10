//
//  CommonUtil.m
//  PeaceTV
//
//  Created by Ja Young Park on 2017. 8. 12..
//  Copyright © 2017년 kandc. All rights reserved.
//

#import "CommonUtil.h"
#import <SBJson4.h>

@implementation CommonUtil

+ (BOOL)isiPhoneXScreen {
    if (@available(iOS 11.0, *)) {
        if ([UIApplication sharedApplication].windows != nil && [UIApplication sharedApplication].windows.count > 0) {
            UIEdgeInsets edgeInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;
            if (edgeInsets.top != 0 && edgeInsets.bottom != 0) {
                return YES;
            }
        }
        
    } else {
        return NO;
    }
    return NO;
}

+ (BOOL)isiPhoneEXScreen {
    BOOL result = [self isiPhoneXScreen];
    if (!result) {
        result = [self isiPhone4_7_5_5_INCH];
    }
    return result;
}

// json데이터 파싱
+(id)jsonParser:(NSString*)str
{
    __block id object = nil;
    SBJson4ValueBlock block = ^(id obj, BOOL *stop) {
        object = obj;
    };
    
    SBJson4ErrorBlock eh = ^(NSError* err){
        NSLog(@"Oops: %@",err);
    };
    
    id parser = [SBJson4Parser multiRootParserWithBlock:block
                                           errorHandler:eh];
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    SBJson4ParserStatus status = [parser parse:data];
    
    NSLog(@"Status: %u",status);
    
    return object;
}

// json데이터 파싱
+(id)jsonParserWithData:(NSData*)data
{
    __block id object = nil;
    SBJson4ValueBlock block = ^(id obj, BOOL *stop) {
        object = obj;
    };
    
    SBJson4ErrorBlock eh = ^(NSError* err){
        NSLog(@"Oops: %@",err);
    };
    
    id parser = [SBJson4Parser multiRootParserWithBlock:block
                                           errorHandler:eh];
    
    SBJson4ParserStatus status = [parser parse:data];
    
    NSLog(@"Status: %u",status);
    
    return object;
}

+ (NSString*)getChangeTimeToSecond:(int)second
{
    int hour = second / 3600;
    int min = (second % 3600) / 60;
    int sec = (second % 3600) % 60;
    
    NSString *time = @"";
    if (hour > 0) {
        time = [NSString stringWithFormat:@"%ld:%02ld:%02ld",(long)hour,(long)min,(long)sec];
    } else if (min > 0) {
        time = [NSString stringWithFormat:@"%02ld:%02ld",(long)min,(long)sec];
    } else if (sec >= 0) {
        time = [NSString stringWithFormat:@"00:%02ld",(long)sec];
    }
    
    return time;
}

+ (NSString*)getChangeDateFormat:(NSString *)pDate tdateFormat:(NSString*)format changeDateFormat:(NSString*)cFormat
{
    pDate = [pDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    pDate = [pDate stringByReplacingOccurrencesOfString:@"Z" withString:@""];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Seoul"];
    [dateFormat setTimeZone:timeZone];
    
    if ([format length] > 0) {
        [dateFormat setDateFormat:format];
    }else {
        [dateFormat setDateFormat:@"yyyyMMdd"];
    }
    
    NSDate *date = [dateFormat dateFromString:pDate];
    if ([cFormat length] > 0) {
        [dateFormat setDateFormat:cFormat];
    }else {
        [dateFormat setDateFormat:@"yyyyMMdd"];
    }
    
    return [dateFormat stringFromDate:date];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -------------------------------------------------------------------
#pragma mark < NSUserDefaults Methods >

+ (void) writeIntToDefault:(int) nValue KEY:(NSString *)strKey
{
    NSUserDefaults *defaults;
    defaults = NUD;
    
    [defaults setInteger:nValue forKey:strKey];
    [defaults synchronize];
}

+ (int) readIntFromDefault:(NSString *)strKey
{
    NSUserDefaults *defaults;
    defaults = NUD;
    
    return (unsigned long)[defaults integerForKey:strKey];
}

+ (void) writeObjectToDefault:(id)idValue KEY:(NSString *)strKey
{
    NSUserDefaults *defaults;
    defaults = NUD;
    
    [defaults setObject:idValue forKey:strKey];
    [defaults synchronize];
}

+ (id) readObjectFromDefault:(NSString *)strKey
{
    NSUserDefaults *defaults;
    defaults = NUD;
    
    return [defaults objectForKey:strKey];
}


+ (void) writeBoolToDefault:(BOOL)bValue KEY:(NSString *)strKey
{
    NSUserDefaults *defaults;
    defaults = NUD;
    
    [defaults setBool:bValue forKey:strKey];
    [defaults synchronize];
}

+(BOOL) readBoolFromDefault:(NSString *)strKey
{
    NSUserDefaults *defaults;
    defaults = NUD;
    
    return [defaults boolForKey:strKey];
}

+ (void) writeFloatToDefault:(float) fValue KEY:(NSString *)strKey
{
    NSUserDefaults *defaults;
    defaults = NUD;
    
    [defaults setFloat:fValue forKey:strKey];
    [defaults synchronize];
}

+(float) readFloatFromDefault:(NSString *)strKey
{
    NSUserDefaults *defaults;
    defaults = NUD;
    
    return [defaults floatForKey:strKey];
}

@end

@implementation UIButton (UIPeaceTVButton)
+ (UIButton *)borderButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderColor = UIColor.grayColor.CGColor;
    button.layer.borderWidth = 1;
    
    return button;
}
@end

@implementation NSString (utility)

- (int) indexOf:(NSString *)text {
    NSRange range = [self rangeOfString:text];
    if ( range.length > 0 ) {
        return (int)range.location;
    } else {
        return -1;
    }
}

- (NSString *)URLDecode
{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)URLEncode
{
    return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding)));
}

-(NSString *) stringByStrippingHTML
{
//    NSRange r;
    NSString *s = [self copy];
//    s = [s stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
//    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
//        s = [s stringByReplacingCharactersInRange:r withString:@""];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:[s dataUsingEncoding:NSUTF8StringEncoding]
                                                                      options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                           documentAttributes:nil error:nil];
    NSString *actualString= [attrString string];
    return actualString;
}

@end

@implementation UIViewController (NavigationBar)

+ (void)globalResignFirstResponderView:(UIView*) view {
    
    if ([view respondsToSelector:@selector(resignFirstResponder)]){
        if ([view isFirstResponder]) {
            [view resignFirstResponder];
        }
    }
    
    for (UIView * subview in [view subviews]){
        [self globalResignFirstResponderView:subview];
    }
}

+ (void)globalResignFirstResponder {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    for (UIView * view in [window subviews]){
        [self globalResignFirstResponderView:view];
    }
}
@end
