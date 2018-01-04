#pragma once
#include <vector>

//并查集	： 合并集合，查找集合中的元素
//性质	： 该算法不支持分割集合
//算法	： 用集合中的某个元素（代表元）代表该集合
//用途	： 1.维护无向图的连通性。
//			1.1 判断两个点是否在同一连通区块内。（根节点相同则在同一连通区块）
//			1.2 判断增加一条边是否产生环。（在同一连通区块中增加一条边会产生环）
//		： 2.用在求解最小生成树的Kruskal算法里。

class CDisjointSet
{
protected:
	std::vector<int> pre;   //上级

public:
	CDisjointSet(){}
	CDisjointSet(std::vector<int> &_pre){ pre = _pre;}
	~CDisjointSet(){}

	//查找根节点，同时做路径压缩
	int find(int x)
	{
		int r=x;
		while(pre[r] != r)    //循环查找上级，直到上级为自己，则为根节点
			r = pre[r];

		//路径压缩，把x的所有上级的上级设为根节点，提升下一次查找速度
		int i=x, j;
		while(i != r)
		{
			j = pre[i];
			pre[i] = r;
			i = j;
		}

		return r;
	}

	//合并x, y所在集合
	void join(int x, int y)
	{
		int fx = find(x), fy = find(y);
		if (fx != fy)
			pre[fx] = fy;
	}

};