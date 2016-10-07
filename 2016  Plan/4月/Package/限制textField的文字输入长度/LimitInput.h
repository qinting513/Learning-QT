


/** 使用方法:
 直接将这两个文件拉到工程中，
 设置需要限制输入长度的textField的limit属性即可，如下：
 
 修改数字 即可限制长度
 [self.textfield setValue:@4 forKey:@"limit"];
 [self.textview setValue:@6 forKey:@"limit"];
 
 */


#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

#define PROPERTY_NAME @"limit"

#define DECLARE_PROPERTY(className) \
@interface className (Limit) @end

DECLARE_PROPERTY(UITextField)
DECLARE_PROPERTY(UITextView)

@interface LimitInput : NSObject

@property(nonatomic, assign) BOOL enableLimitCount;

+(LimitInput *) sharedInstance;

@end
