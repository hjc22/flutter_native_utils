#import "NativeUtilsPlugin.h"
#import <native_utils/native_utils-Swift.h>

@implementation NativeUtilsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeUtilsPlugin registerWithRegistrar:registrar];
}
@end
