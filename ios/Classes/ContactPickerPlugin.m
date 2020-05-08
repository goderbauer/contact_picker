#import "ContactPickerPlugin.h"
#if __has_include(<contact_picker/contact_picker-Swift.h>)
#import <contact_picker/contact_picker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "contact_picker-Swift.h"
#endif

@implementation ContactPickerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [SwiftContactPickerPlugin registerWithRegistrar:registrar];
}
@end
