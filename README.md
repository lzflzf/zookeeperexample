# zookeeperexample

zookeeper 使用案例

1： 感知一个Znode节点的变化       fetch到指定的Znode后启动指定的服务， 节点存储的数据发生变化后重启服务，节点被删除后关闭服务。

2： 读取该节点变化后的data  (其实可以理解为一个配置项,zookeeper能作为配置中心)

3： 重启一个进程 (说得高大上一点这里可以做HA,高可用)

4： HA和Leader选举并不是一回事

5： 说得很简单，但做起来很难，看得再多，不一定能理解，能写

6: 事件驱动  event driven

7： 多线程

8：main 线程进入阻塞状态。直到接收 notifyall() 命令 , 以及 dead为true , main 线程退出，整个进程退出

example 来源于   https://zookeeper.apache.org/doc/trunk/javaExample.html

