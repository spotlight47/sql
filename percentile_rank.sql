WITH MarksRnkCnt AS
(
  SELECT studentid, mark,
    RANK() OVER(ORDER By mark) AS rnk,
	COUNT(*)OVER()AS cnt
  FROM dbo.Marks
 )
 SELECT studentid, mark,
 1.*(rnk-1)/(cnt-1) as pctrnk
 FROM MarksRnkCnt
 ORDER BY mark;
