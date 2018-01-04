#pragma once
#include <vector>

//���鼯	�� �ϲ����ϣ����Ҽ����е�Ԫ��
//����	�� ���㷨��֧�ַָ��
//�㷨	�� �ü����е�ĳ��Ԫ�أ�����Ԫ������ü���
//��;	�� 1.ά������ͼ����ͨ�ԡ�
//			1.1 �ж��������Ƿ���ͬһ��ͨ�����ڡ������ڵ���ͬ����ͬһ��ͨ���飩
//			1.2 �ж�����һ�����Ƿ������������ͬһ��ͨ����������һ���߻��������
//		�� 2.���������С��������Kruskal�㷨�

class CDisjointSet
{
protected:
	std::vector<int> pre;   //�ϼ�

public:
	CDisjointSet(){}
	CDisjointSet(std::vector<int> &_pre){ pre = _pre;}
	~CDisjointSet(){}

	//���Ҹ��ڵ㣬ͬʱ��·��ѹ��
	int find(int x)
	{
		int r=x;
		while(pre[r] != r)    //ѭ�������ϼ���ֱ���ϼ�Ϊ�Լ�����Ϊ���ڵ�
			r = pre[r];

		//·��ѹ������x�������ϼ����ϼ���Ϊ���ڵ㣬������һ�β����ٶ�
		int i=x, j;
		while(i != r)
		{
			j = pre[i];
			pre[i] = r;
			i = j;
		}

		return r;
	}

	//�ϲ�x, y���ڼ���
	void join(int x, int y)
	{
		int fx = find(x), fy = find(y);
		if (fx != fy)
			pre[fx] = fy;
	}

};