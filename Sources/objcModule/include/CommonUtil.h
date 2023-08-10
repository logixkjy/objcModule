//
//  CommonUtil.h
//  PeaceTV
//
//  Created by Ja Young Park on 2017. 8. 12..
//  Copyright © 2017년 kandc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject

+ (BOOL)isiPhone4_7_5_5_INCH;
+ (BOOL)isiPhoneXScreen;
+ (BOOL)isiPhoneEXScreen;

+ (id)jsonParser:(NSString*)str;
+ (id)jsonParserWithData:(NSData*)data;

+ (NSString*)stringByStrippingHTML:(NSString*)stringHtml;

+ (NSString*)getNumberFormat:(int)value;
+ (NSString*)getChangeTimeToSecond:(int)second;

+ (NSString*)getChangeDateFormat:(NSString *)pDate tdateFormat:(NSString*)format changeDateFormat:(NSString*)cFormat;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (void) writeIntToDefault:(int) nValue KEY:(NSString *)strKey;
+ (int) readIntFromDefault:(NSString *)strKey;
+ (void) writeObjectToDefault:(id)idValue KEY:(NSString *)strKey;
+ (id) readObjectFromDefault:(NSString *)strKey;
+ (void) writeBoolToDefault:(BOOL)bValue KEY:(NSString *)strKey;
+ (BOOL) readBoolFromDefault:(NSString *)strKey;
+ (void) writeFloatToDefault:(float) fValue KEY:(NSString *)strKey;
+ (float) readFloatFromDefault:(NSString *)strKey;
@end

@interface UIButton (UIPeaceTVButton)
+ (UIButton *)borderButton;
@end

@interface NSString (utility)

- (int) indexOf:(NSString *)text;
- (NSString *)URLDecode;
- (NSString *)URLEncode;
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;
- (NSString *) stringByStrippingHTML;

@end

@interface UIViewController (NavigationBar)

+ (void)globalResignFirstResponderView:(UIView*) view;
+ (void)globalResignFirstResponder;
@end
