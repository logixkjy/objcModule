//
//  JsonUtil.h
//  
//
//  Created by James.2329 on 2023/08/08.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JsonUtil : NSObject

+ (id)jsonParser:(NSString*)str;
+ (id)jsonParserForPath:(NSString*)path;
+ (id)jsonParserWithData:(NSData*)data;

+ (id)jsonWriter:(id)param;

@end

NS_ASSUME_NONNULL_END
