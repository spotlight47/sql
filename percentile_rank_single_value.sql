/***
LISTING 4:  Query Calculating Percentile Rank for any Single Value
Author: Robert Lazo
Date:  1/2/2020

***/

DECLARE @mark AS INT;
SET @mark = 85;

WITH MarksRnkCnt AS
(
SELECT studentid, mark,
  RANK() OVER(ORDER BY mark) AS rnk,
  DENSE_RANK() OVER(ORDER BY mark) AS drnk,
  COUNT(*) OVER() AS cnt
FROM dbo.Marks
),
PctRanks AS
(
  SELECT DISTINCT
    drnk AS rownum,
	mark,
	1.*(rnk-1)/(cnt-1) AS pctrnk
  FROM MarksRnkCnt
),
PctRankRanges AS
(
  SELECT
    Cur.rownum,
	Cur.mark AS mark_from, Nxt.mark AS mark_to,
	Cur.pctrnk AS pctrnk_from, Nxt.pctrnk AS pctrnk_to
FROM PctRanks AS Cur
   JOIN PctRanks AS Nxt
     ON Nxt.rownum = Cur.rownum +1
)
SELECT
    CASE @mark
	   WHEN mark_from THEN pctrnk_from
	   WHEN mark_to THEN pctrnk_to
	   ELSE  pctrnk_from
	   + 1.*(@mark - mark_from)
	   / (mark_to - mark_from)
	   * (pctrnk_to - pctrnk_from)
	END AS pctrnk
FROM PctRankRanges
WHERE (@mark > mark_from AND @mark <= mark_to)
  OR (rownum = 1 AND @mark = mark_from);

