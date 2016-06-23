//
//  People.m
//  runtimeDemo
//
//  Created by comma on 16/6/23.
//  Copyright © 2016年 lj. All rights reserved.
//

#import "People.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation People



//http://upload.ianisme.com/wp-content/uploads/2016/01/objective-runtime-6.png

//动态添加方法

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if ([NSStringFromSelector(sel) isEqualToString:@"sing"]) {
        class_addMethod(self, sel, (IMP)otherSing, "v@:");
        
        return YES;
    }
    
    return [super resolveInstanceMethod: sel];
}

void otherSing(id self,SEL cmd){
    
    NSLog(@"hello");
}

//归档和解挡

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([People class], &count);
    
    for (NSUInteger i = 0; i< count; i++) {
        
        Ivar ivar = ivars[i];
        
        const char *name = ivar_getName(ivar);
        
        NSString *key = [NSString stringWithUTF8String:name];
        
        id value = [self valueForKey:key];
        
        [aCoder encodeObject:value forKey:key];
    }
    
    free(ivars);
    
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self ) {
        unsigned int count = 0;
        
        Ivar *ivars = class_copyIvarList([People class], &count);
        
        for (NSUInteger i = 0; i< count; i++) {
            
            Ivar ivar = ivars[i];
            
            const char *name = ivar_getName(ivar);
            
            NSString  *key = [NSString stringWithUTF8String:name];
            
            id value = [aDecoder decodeObjectForKey:key];
            
            [self setValue:value forKey:key];
        }
        
        free(ivars);
        
    }
    
    return self;
}

/**
- (NSDictionary *)allproperties
{
    
    unsigned int count = 0;
    
    //获取类的所有属性，如果没有，属性count就为0
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableDictionary *resultDict = [NSMutableDictionary mutableCopy];
    
    for (NSUInteger i = 0; i < count; i++) {
        
        //获取属性的名称和值
        
        const char *propertyName = property_getName(properties[i]);
        
        NSString *name = [NSString stringWithUTF8String:propertyName];
        
        id propertyValue = [self valueForKey:name];
        
        if (propertyValue) {
            resultDict[name] = propertyValue;
        }else{
            resultDict[name] = @"haha妹纸";
        }
    }
    
    //这里的properties是一个数组指针，我们需要使用free函数来释放内存
    free(properties);
    
    return resultDict;
}

- (NSDictionary *)allIvars
{
    unsigned int count  = 0;
    
    NSMutableDictionary *resultDict = [NSMutableDictionary mutableCopy];
    
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (NSUInteger i = 0; i< count; i++) {
        
        const char *varName = ivar_getName(ivars[i]);
        NSString *name = [NSString stringWithUTF8String:varName];
        id varValue = [self valueForKey:name];
        
        if (varValue) {
            resultDict[name] = varValue;
        }else{
            resultDict[name] = @"haha";
         }
    }
    
    free(ivars);
    
    return resultDict;
}

- (NSDictionary *)allMethods
{
    unsigned int count = 0;
    
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    
    Method *methods = class_copyMethodList([self class], &count);
    
    for (NSUInteger i = 0; i< count; i++) {
        
        
        //获取方法名称
        SEL methodSel = method_getName(methods[i]);
        
        const char *methodName = sel_getName(methodSel);
        
        NSString *name = [NSString stringWithUTF8String:methodName];
        
        //获取方法列表
        int arguments = method_getNumberOfArguments(methods[i]);
        
        resultDict[name] = @(arguments - 2);
    }
    
    free(methods);
    
    return resultDict;
}
 
 **/

@end
