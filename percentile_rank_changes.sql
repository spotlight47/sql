/***
LISTING 3: Query Calculationg Percentile Rank Ranges
Author:  Robert Lazo
Date:  02 January 20
p. 24 November 2008 SQL Server Magazine - Itzik Ben-Gan
***/
WITH MarksRnkCnt AS
(
  SELECT studentid, mark,
    RANK() OVER(ORDER BY mark) AS rnk,
	DENSE_RANK() OVER(ORDER BY mark) AS drnk,
	COUNT(*) OVER () AS cnt
	FROM dbo.Marks
),
PctRanks AS
(
  SELECT DISTINCT
    drnk as rownum,
	mark,
	1.*(rnk-1)/(cnt-1) AS pctrnk
  FROM MarksRnkCnt
)
SELECT
  Cur.rownum,
  Cur.mark AS mark_from, Nxt.mark AS mark_to,
  Cur.pctrnk AS pctrnk_from, Nxt.pctrnk AS
  pctrnk_to
FROM PctRanks As Cur
  JOIN PctRanks AS Nxt
    ON Nxt.rownum = Cur.rownum + 1;