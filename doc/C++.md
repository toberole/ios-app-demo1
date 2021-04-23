C++
RAII
Resource Acquisition is Initialization， 资源获取即是初始化 ，也就是说在构造函数中申请分配资源，在析构函数中释放资源。
使用对象来管理资源: （利用栈回退时一定会释放栈上对象的机制,调用对象析构函数）内存，硬件设备，网络句柄等

RTTI
RTTI(Run Time Type Identification)即通过运行时类型识别，程序能够使用基类的指针或引用来检查着这些指针或引用所指的对象的实际派生类型。
