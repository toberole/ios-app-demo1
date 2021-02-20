注意View的tag不能为0

UINavigationController是一个容器视图控制器，其内部可以展示多个UIViewController，UINavigationController的视图由三部分组成，最上面的UINavigationBar，最下面的默认隐藏的toolbar，以及中间部分UIViewController中的View

iOS开发-界面之间的跳转
1.改变window的根视图
[UIApplication sharedApplication].keyWindow.rootViewController = VC;
2.利用UINavigationController进行push、pop （最常用）
[self.navigationController pushViewController:VC animated:YES];
 
[self.navigationController popViewControllerAnimated:YES];
3.模态弹出
3.1基本使用
[self presentViewController:vc animated:YES completion:nil];//弹出vc
[self dismissViewControllerAnimated:YES completion:nil];//收回vc
3.2 presentedViewController 与 presentingViewController 的理解
举个栗子：有A和B两个控制器，当A弹出B，此时 A.presentedViewController = B ，B.presentingViewController = A 。

3.3 dismissViewControllerAnimated 的使用

当A弹出B后，想要从B回到A时，需要A调用dismissViewControllerAnimated，而不是B控制器。

但某些时候，B中的某些操作需要返回A，这时，根据上文所讲的关系，我们可以在B中调用下面这一句。

[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

UINavigationController管理UINavigationBar
UINavigationBar管理所有的UIViewController中的navigationItem.
UINavigationBar是UINavigationController的属性，我们在设置了UINavigationBar的外观后，其将作用于全部的UIViewController。navigationItem是UIViewController的属性，它是配置这个UIViewController上面的UINavigationBar的内容的。UINavigationBar中有一个堆栈，这个堆栈是一个UINavigationItem堆栈，当把一个UIViewController push进栈的时候，它的navigationItem也会被push进UINavigationBar的堆栈。所以UINavigationBar的这个堆栈和这个UIViewController堆栈是一一对应的。

注意：
    在使用dismissViewControllerAnimated时，ViewController中的资源不释放，会导致当前ViewController的dealloc得不到调用。

GCD三种队列：
    主队列，全局队列，自定义队列
在iOS中有三种方法可以实现并发性：threads、dispatch queues和operation queues。



同步dispatch_sync与异步dispatch_async任务派发
串行队列与并发队列dispatch_queue_t
dispatch_once_t只执行一次
dispatch_after延后执行
串行与并发(Serial和Concurrent)：
这个概念在创建操作队列的时候有宏定义参数，用来指定创建的是串行队列还是并行队列。

串行指的是队列内任务一个接一个的执行，任务之间要依次等待不可重合，且添加的任务按照先进先出FIFO的顺序执行，但并不是指这就是单线程，只是同一个串行队列内的任务需要依次等待排队执行避免出现竞态条件，但仍然可以创建多个串行队列并行的执行任务，也就是说，串行队列内是串行的，串行队列之间仍然是可以并行的，同一个串行队列内的任务的执行顺序是确定的(FIFO)，且可以创建任意多个串行队列；

并行指的是同一个队列先后添加的多个任务可以同时并列执行，任务之间不会相互等待，且这些任务的执行顺序执行过程不可预测。

同步和异步任务派发(Synchronous和Asynchronous)：GCD多线程编程时经常会使用dispatch_async和dispatch_sync函数往指定队列中添加任务块，区别就是同步和异步。同步指的是阻塞当前线程，要等添加的耗时任务块block完成后，函数才能返回，后面的代码才可以继续执行。如果在主线上，则会发生阻塞，用户会感觉应用不响应，这是要避免的。而有时需要使用同步任务的原因是想保证先后添加的任务要按照编写的逻辑顺序依次执行；异步指的是将任务添加到队列后函数立刻返回，后面的代码不用等待添加的任务完成返回即可继续执行。





OC中不能直接修改对象结构体属性的成员变量

[UIImage imageNamed:@""];// 加载的图片数据会缓存在内存中，再次加载相同的图片，加载速度快，但图片如果过多 会导致内存压力。
[UIImage imageWithContentsOfFile:@""];// 加载图片数据不会缓存在内存中
























