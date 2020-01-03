CREATE VIEW vwProductOrderDetails
AS
SELECT CustomerID
, OrderDate
, OrderQty
, UnitPrice
, Product.Name as Product
FROM Sales.SalesOrderHeader
    INNER JOIN Sales.SalesOrderDetail
      ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
    INNER JOIN Production.Product
      ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID