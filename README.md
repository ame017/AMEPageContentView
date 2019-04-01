# AMEPageContentView
A page content view for iOS

[![996.icu](https://img.shields.io/badge/link-996.icu-red.svg)](https://996.icu) [![LICENSE](https://img.shields.io/badge/license-NPL%20(The%20996%20Prohibited%20License)-blue.svg)](https://github.com/996icu/996.ICU/blob/master/LICENSE)

##### ![cn](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/China.png) Chinese (Simplified): [中文说明](README_chs.md)

# What is this?
Just see the display image:
![display](Display/1.gif)

# Characteristics

1. lazyLoad
2. automic child viewcontroller life circle
![display](Display/2.png)

3. xib or code init both OK

# How To use?

Supported properties:

```
//The necessary
self.contentView.fatherViewController = self;
self.contentView.itemArray            = self.itemArray;

//optional
self.contentView.canScroll            = YES;
self.contentView.buttonWidth          = 100;
self.contentView.underLineLenth       = 100;
self.contentView.underLineHeight      = 2;
self.contentView.chooseViewHeight     = 60;
self.contentView.selectedColor        = [UIColor orangeColor];
self.contentView.notSelectedColor     = [UIColor greenColor];
self.contentView.underLineColor       = [UIColor orangeColor];
self.contentView.delegate             = self;
```

### DO NOT FORGET

add this method to father viewcontroller
```
- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
return NO;
}
```

# Install
```
pod 'AMEPageContentView'
```
```
#import <AMEPageContentView.h>
```


