//
//  ViewController.m
//  runtimeDemo
//
//  Created by comma on 16/6/22.
//  Copyright © 2016年 lj. All rights reserved.
//

#import "ViewController.h"
#import <objc/objc-runtime.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

void sayFunction(id self,SEL _cmd,id some){
    
    NSLog(@"hello oc");
    
}


int main(int argc,const char *argv[]){
    
    //动态创建对象
    
    Class Person = objc_allocateClassPair([NSObject class], "Person", 0);
    
    //为该类添加nsstring *name 成员变量
    class_addIvar(Person, "_name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));

    class_addIvar(Person, "_age", sizeof(int), sizeof(int), @encode(int));
    
    SEL s = sel_registerName("say:");
    
    class_addMethod(Person, s, (IMP)sayFunction, "v@:@");
    
    //注册该类
    objc_registerClassPair(Person);
    
    //创建一个类的实例对象
    
    id peopleInstance = [[Person alloc] init];
    
    [peopleInstance setValue:@"苍老师" forKey:@"name"];
    
    Ivar ageIvar = class_getInstanceVariable(Person, "_age");
    
    object_setIvar(peopleInstance, ageIvar, @18);
    
    ((void(*)(id,SEL,id))objc_msgSend)(peopleInstance,s,@"大家好");
    
    
    peopleInstance = nil;
    
    //销毁类
    objc_disposeClassPair(Person);

    
}

@end
