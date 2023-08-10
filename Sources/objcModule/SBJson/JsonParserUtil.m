//
//  JsonParserUtil.m
//  
//
//  Created by James.2329 on 2023/08/08.
//

#import "JsonParserUtil.h"
#import "SBJson5.h"

@implementation JsonParserUtil

+ (id)jsonParser:(NSString*)str
{
    __block id object = nil;
    
    SBJson5ValueBlock block = ^(id obj, BOOL *stop) {
        object = obj;
    };
    
    SBJson5ErrorBlock eh = ^(NSError* err){
        NSLog(@"Oops: %@",err);
    };
    
    id parser = [SBJson5Parser multiRootParserWithBlock:block
                                           errorHandler:eh];
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [parser parse:data];
    
    return object;
}

+ (id)jsonParserForPath:(NSString*)path
{
    __block id object = nil;
    
    SBJson5ValueBlock block = ^(id obj, BOOL *stop) {
        object = obj;
    };
    
    SBJson5ErrorBlock eh = ^(NSError* err){
        NSLog(@"Oops: %@",err);
    };
    
    id parser = [SBJson5Parser multiRootParserWithBlock:block
                                           errorHandler:eh];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    [parser parse:data];
    
    return object;
}

+ (id)jsonParserWithData:(NSData*)data
{
    __block id object = nil;
    
    SBJson5ValueBlock block = ^(id obj, BOOL *stop) {
        object = obj;
    };
    
    SBJson5ErrorBlock eh = ^(NSError* err){
        NSLog(@"Oops: %@",err);
    };
    
    id parser = [SBJson5Parser multiRootParserWithBlock:block
                                           errorHandler:eh];
    
    [parser parse:data];
    
    return object;
}

@end
