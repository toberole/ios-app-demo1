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
































