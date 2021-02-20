#ifndef UIView_Note_h
#define UIView_Note_h


/**
 视图的几何属性
 视图有 frame，center，bounds 等几个基本几何属性，其中:

 frame 使用的最多，其坐标位置都是相对于父视图的，可以用于确定本视图在父视图中的位置和其自身的大小
 center 的坐标位置也是相对于父视图的，通常用于移动，旋转等动画操作
 bounds 是相对于自身的，通常情况下就是（0,0,width,height)， bounds 的含义可以认为是当前 view 被允许绘制的范围
 视图的 ContentMode
 视图在初次绘制完成后，系统会对绘制结果进行快照，之后尽可能地使用快照，避免重新绘制。如果视图的几何属性发生改变，系统会根据视图的 contentMode 来决定如何改变显示效果。

 默认的 contentMode 是 UIViewContentModeScaleToFill ，系统会拉伸当前的快照，使其符合新的 frame 尺寸。大部分 contentMode 都会对当前的快照进行拉伸或者移动等操作。如果需要重新绘制，可以把 contentMode 设置为 UIViewContentModeRedraw，强制视图在改变大小之类的操作时调用drawRect:重绘。

 动画
 可以以动画的形式改变视图的下面这些属性，只需要告诉系统动画开始和结束时的数值，系统会自动处理中间的过渡过程。
 frame、bounds、center、transform、alpha、backgroundColor、contentStretch

 UIWindow:
 一、UIWindow 是一种特殊的UIView，通常在一个程序中只会有一个UIWindow，但可以手动创建多个 UIWindow，同时加到程序里面。
UIWindow 在程序中主要起到三个作用：
　　1、作为容器，包含app所要显示的所有视图
　　2、传递触摸消息到程序中view和其他对象
　　3、与UIViewController协同工作，方便完成设备方向旋转的支持
二、通常我们可以采取两种方法将 view 添加到 UIWindow 中：
1、addSubview
 直接将view通过addSubview 方式添加到 window 中，程序负责维护view的生命周期以及刷新，但是并不会为去理会 view 对应的ViewController，因此采用这种方法将 view 添加到 window 以后，我们还要保持 view 对应的 ViewController 的有效性，不能过早释放。
2、rootViewController
 rootViewController是UIWindow的一个遍历方法，通过设置该属性为要添加view对应的ViewController，UIWindow将会自动将其view添加到当前window中，同时负责ViewController和view的生命周期的维护，防止其过早释放
 三、WindowLevel
 UIWindow在显示的时候会根据UIWindowLevel进行排序的，即Level高的将排在所有Level比他低的层级的前面。下面我们来看UIWindowLevel的定义：

 
 
 
 
 
 
 
 */

#endif /* UIView_Note_h */
