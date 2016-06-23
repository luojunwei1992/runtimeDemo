//
//  Person.m
//  runtimeDemo
//
//  Created by comma on 16/6/23.
//  Copyright © 2016年 lj. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation Person

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        for (NSString *key in dictionary.allKeys) {
            
            id value = dictionary[key];
            
            SEL setter = [self propertySetterByKey:key];
            
            if (setter) {
                
                ((void(*)(id,SEL,id))objc_msgSend)(self,setter,value);
            }
        }
    }
    
    return self;
}

- (NSDictionary *)covertToDictionary
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    if (count != 0) {
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
        
        for (NSUInteger i = 0; i <count; i++) {
            const void *propertyName = property_getName(properties[i]);
            
            NSString *name = [NSString stringWithUTF8String:propertyName];
            
            SEL getter = [self propetyGetterByKey:name];
            
            if (getter) {
                
                id value = ((id (*)(id ,SEL))objc_msgSend)(self,getter);
                
                if (value) {
                    resultDict[name] = value;
                }else{
                    
                    resultDict[name] = @"haha";
                }
            }
        }
        
        free(properties);
        
        return resultDict;
    }
    
    free(properties);
    
    return nil;
}

#pragma mark -----private methods

//生成setter方法
- (SEL)propertySetterByKey:(NSString *)key
{
    //首字母大写
    NSString *propertySetterName = [NSString stringWithFormat:@"set%@",key.capitalizedString];

    SEL setter = NSSelectorFromString(propertySetterName);
    
    if([self respondsToSelector:setter]){
        
        return setter;
    }
    
    return nil;
}


//生成getter方法

- (SEL)propetyGetterByKey:(NSString *)key
{
    SEL getter = NSSelectorFromString(key);
    
    if ([self respondsToSelector:getter]) {
        
        return getter;
    }
    
    return nil;
}

@end
