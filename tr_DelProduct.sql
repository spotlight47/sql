/***
Checks for exisiting sales orders using
the product being deleted.
Prevents deletion if orders exist.
Practice Tutoral pg.120
2020-01-02
Robert Lazo
***/
CREATE TRIGGER tr_DelProduct
ON Product
FOR DELETE
AS
  IF (SELECT Count(*) FROM SalesOrderDetail
    INNER JOIN Deleted ON SalesOrderDetail.ProductID = Deleted.ProductID > 0
  BEGIN 
    RAISERROR 5009 'Cannot delete a rpodcut with sales orders'
    ROLLBACK TRANSACTION
    RETURN
END