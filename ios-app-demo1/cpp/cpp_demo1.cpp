#include "cpp_demo1.hpp"
#include <string>
#include <iostream>
#include <variant>
#include <thread>
#include <future>
#include "cpp_demo2.hpp"

void cpp_demo1_test1(void){
    std::string str = "hello";
    std::cout<<"str: "<<str<<std::endl;
    
    std::variant<int,std::string> v1 = {1};
    std::cout<<"index: "<<v1.index()<<std::endl;
//    int i = std::get<int>(v1);
//    std::cout<<"i: "<<i<<std::endl;
    
    std::future<int> future = std::async(std::launch::async, [](){
        std::this_thread::sleep_for(std::chrono::seconds(3));
        return 8;
    });
    
    std::cout<<"std::future: "<<future.get()<<std::endl;
    
}

void cpp_demo1_test2(void){
    cpp_demo2 cd(1);
}
