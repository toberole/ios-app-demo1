#include "NBCppBaseDemo.hpp"
#include <map>
#include <string>

/**
 insert()方法：若插入的元素的键值已经存在于map中，那么插入就会失败，不会修改元素的键对应的值；若键值在map中查不到，那么就会将该新元素加到map中去。

 下标[key]方法：若插入元素的键值已经存在于map中，那么会更新该键值对应的值为新的元素的值；若该键值在map中找不到，那么就会新建一个键值为该键（key）的元素，并将key对应的值赋值为默认值（默认构造函数生成的对象）。
 */
void cppBaseDemo_test1(){
    std::map<std::string, std::string> map1;
    map1["name1"] = "name1";
    map1["name2"] = "name2";
    
    // map中存在键值为“name2”的值 插入失败
    map1.insert(std::make_pair("name2", "123"));
    
    std::map<std::string, std::string>::iterator iter;
    for(iter = map1.begin(); iter != map1.end(); iter++) {
        printf("key: %s,value: %s\n",(iter->first).c_str(),(iter->second).c_str());
    }
}
