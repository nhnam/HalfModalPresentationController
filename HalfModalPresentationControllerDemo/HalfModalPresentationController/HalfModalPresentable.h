//
//  HalfModalPresentable.h
//  Ring
//
//  Created by Nam Nguyen on 8/22/18.
//  Copyright © 2018 RMD Operations Pte. Ltd. All rights reserved.
//

#ifndef HalfModalPresentable_h
#define HalfModalPresentable_h

@protocol HalfModalPresentable<NSObject>
- (void)maximizeToFullScreen;
- (BOOL)isHalfModalMaximized;
@end

#endif /* HalfModalPresentable_h */
