#import "NBView3.h"

@implementation NBView3


/**
 如果需要在View中绘制新的一些图形，比如曲线，直线，椭圆等，都需要重写DrawRect方法才可以
 
 当View显示的时候调用(ViewWillAppear和ViewDidAppear之间)。如果View是隐藏的，也会调用的。转屏会调用，从新设置Frame时会调用；
 
 参数rect:当View的bounds 在drawRect方法当中系统已经帮你创建一个跟View相关联的上下文(Layer上下文),只要获取上下文就可以了（上下文相当于当前View在父view中的坐标）
 
 1.DrawRect只可以由系统调用，不可自己调用。如果想触发该方法，可以调用setNeedsDisplay，或者setNeedsDisplayInRectangle：以触发drawRect：，但有个前提条件是rect不能为0；
 
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code.
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSLog(@"上下文，%@",context);
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, 1.0);
    
    //设置颜色
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    //开始一个起始路径
    CGContextBeginPath(context);
    //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
    CGContextMoveToPoint(context, 0, 0);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, 100, 100);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, 0, 150);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, 50, 180);
    //连接上面定义的坐标点
    CGContextStrokePath(context);

}

//+ (Class)layerClass{
//
//}


@end
