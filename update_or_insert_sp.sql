/*****
Create a stored procedure
Checks for existing Product record
If exists, updates the record.  If not,
inserts a new record
*****/
CREATE PROCEDURE spInsertOrUpdateProduct
-- Input parameters --
  @ProductName nVarChar(50),
  @ProductNumber nVarChar(25),
  @StdCost Money
AS
  IF EXISTS(SELECT * From Product Where ProductNumber = @ProductNumber)
    UPDATE Product SET NAME = @ProductName, StandardCost = @StdCost
    WHERE ProductNumber = @ProductNumber
  ELSE
    INSERT INTO Product (Name, ProductNumber, StandardCost)
    SELECT @ProductName, @ProductNumber, @StdCost
    