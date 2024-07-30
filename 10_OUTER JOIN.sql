-- 10_OUTER JOIN.sql

/*
    # OUTER JOIN
        
        - JOIN ������ �������� ���ؼ� �������� ���ϴ� ���� �߰��� Ȯ���� �� �ִ� JOIN
        - (+)�� ���� ���� �ʿ� null�� �߰��Ͽ� �������� ���ߴ� ���� �߰��� ��ȸ�� �� �ִ�.
        - �⺻Ű �÷��� null�� ������� ������ �ܷ�Ű �÷����� null�� ����ϱ� ������
          ��ȸ���� �ʴ� ��찡 ������ �� �ִ�.(e.g. ���� �μ��� �������� ���� ���)
*/

SELECT * FROM employees e, departments d 
WHERE
-- �μ��� null�� �߰��ؼ��� �������� ���� ����� ���� �ʹٸ� �μ� �ʿ� (+)
-- ����� null�� �߰��ؼ��� �������� ���� �μ��� ���� �ʹٸ� ��� �ʿ� (+)
e.department_id(+) = d.department_id;

-- ����1 : �ι�/�μ���/�ּ�/���ø� ����ϵ� �Ҽӵ� �μ��� ���� ���õ鵵 �Բ� ��ȸ�غ�����.
SELECT department_id, department_name, street_address, city FROM departments d, locations l WHERE d.location_id(+) = l.location_id;

-- ����2 : �Ҽӵ� ����� ���� �μ��� ��ȸ�غ�����.
SELECT * FROM employees e, departments d WHERE e.department_id(+) = d.department_id AND employee_id IS NULL;