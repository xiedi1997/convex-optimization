这是一个用于比较CVX,mosek,gurobi,投影梯度法和次梯度方法的代码集合。

程序所用软件：matlab R2018b

所有文件内容注释

1.    mosek,gurobi文件夹：分别用于使用mosek,gurobi求解器求解问题

2.    l1.m：计算问题目标函数的函数值

3.    l1_cvx_mosek.m：使用cvx的mosek求解器求解问题
输出参数out：
optval：最优值
cputime：运行时间

4.    l1_cvx_gurobi.m：使用cvx的gurobi求解器求解问题
输出参数out：
optval：最优值
cputime：运行时间

5.    l1_mosek.m：直接使用mosek求解器求解问题
输出参数out：
mosek自身输出的结构体

6.    l1_gurobi.m：直接使用gurobi求解器求解问题
输出参数out：
gurobi自身输出的结构体

7.    l1_PGD_primal.m：使用投影梯度法求解问题
输入参数opts：
t：迭代步长
Max：每个mu迭代的最大迭代次数
eps：每个mu迭代的终止精度
输出参数out：
objvalue：最优值

8.    l1_SGD_primal.m：使用次梯度法求解问题
输入参数opts：
t：迭代步长
Max：每个mu迭代的最大迭代次数
eps：每个mu迭代的终止精度
输出参数out：
objvalue：最优值

9.    subgradient_l1.m：计算问题目标函数的次梯度

10.   Test_l1_regularized_problems.m：测试六种方法的各种性能
为保证问题能够复现,选取随机种子97006855.

强调：在使用l1_cvx_mosek.m和l1_cvx_gurobi.m时可能会提示出错,
如果提示出错请再运行第二遍即可.