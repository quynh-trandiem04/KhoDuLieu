-- CREATE DATABASE OlistDWStage
GO

USE OlistDWStage
GO

------------------------------------------------------------------ Staging Dim và Fact -----------------------------------------------------------------------------------
-- Staging Sellers
DROP TABLE IF EXISTS dbo.StageSellers;
SELECT
    Seller_id,
    Seller_zip_code_prefix,
    Seller_city,
    Seller_state
INTO dbo.StageSellers
FROM Olist.dbo.Sellers;

-- Staging Customers
DROP TABLE IF EXISTS dbo.StageCustomers;
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_predix,
    customer_city,
    customer_state
INTO dbo.StageCustomers
FROM Olist.dbo.Customers;

-- Staging Products
DROP TABLE IF EXISTS dbo.StageProducts;
SELECT 
    product_id,
    product_category_name,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
INTO dbo.StageProducts
FROM Olist.dbo.Products;

-- Staging Geolocation
DROP TABLE IF EXISTS dbo.StageGeolocation;
SELECT 
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
INTO dbo.StageGeolocation
FROM Olist.dbo.Geolocation;

-- Staging Payments
DROP TABLE IF EXISTS dbo.StagePayments;
SELECT 
    p.order_id,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    p.payment_type,
    p.payment_installments,
    p.payment_value,
    o.order_purchase_timestamp
INTO dbo.StagePayments
FROM Olist.dbo.OrderPayments p
JOIN Olist.dbo.OrderDataset o ON p.order_id = o.order_id
JOIN Olist.dbo.OrderItems oi  ON o.order_id = oi.order_id;

-- Staging Order Fulfillment
DROP TABLE IF EXISTS dbo.StageOrderFullfilment;
SELECT
    o.order_id,
    o.customer_id,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_delivered_delivery_date,
    DATEDIFF(DAY, o.order_delivered_customer_date, o.order_delivered_delivery_date) AS DeliveryDelay,
    DATEDIFF(DAY, o.order_delivered_carrier_date, o.order_delivered_customer_date)   AS DeliveryTime,
    DATEDIFF(HOUR, o.order_purchase_timestamp, o.order_approved_at)                  AS AcceptTime
INTO dbo.StageOrderFullfilment
FROM Olist.dbo.OrderDataset o
WHERE o.order_status = 'delivered';

-- Staging Sales Item
DROP TABLE IF EXISTS dbo.StageSalesItem;
SELECT 
    od.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    od.customer_id,
    c.customer_zip_code_predix, 
    s.Seller_zip_code_prefix, 
    od.order_purchase_timestamp,
    oi.price,
    oi.freight_value
INTO dbo.StageSalesItem
FROM Olist.dbo.OrderDataset od
JOIN Olist.dbo.OrderItems oi ON od.order_id = oi.order_id
LEFT JOIN Olist.dbo.Customers c ON od.customer_id = c.customer_id
LEFT JOIN Olist.dbo.Sellers s ON oi.seller_id = s.Seller_id;

-- Staging Review
DROP TABLE IF EXISTS dbo.StageReview;
SELECT 
    r.review_id,
    r.order_id,
    o.customer_id,
    r.review_score,
    SUM(oi.freight_value) AS delivery_cost,
    r.review_creation_date,
    r.review_answer_timestamp,
    DATEDIFF(DAY, r.review_creation_date, r.review_answer_timestamp) AS response_time
INTO dbo.StageReview
FROM Olist.dbo.OrderRevierws r
JOIN Olist.dbo.OrderDataset o ON r.order_id = o.order_id
JOIN Olist.dbo.OrderItems oi ON r.order_id = oi.order_id
GROUP BY r.review_id, r.order_id, o.customer_id, r.review_score,
         r.review_creation_date, r.review_answer_timestamp;

------------------------------------------- Load Dim -------------------------------------------------------------
USE OlistDW
GO
DELETE FROM [OlistDW].[dbo].[FactSalesItem];
DELETE FROM [OlistDW].[dbo].[FactOrderFullFilment];
DELETE FROM [OlistDW].[dbo].[FactPayments];
DELETE FROM [OlistDW].[dbo].[FactReview];
GO
DELETE FROM [OlistDW].[dbo].[DimCustomers];
DELETE FROM [OlistDW].[dbo].[DimGeolocation];
DELETE FROM [OlistDW].[dbo].[DimSellers];
DELETE FROM [OlistDW].[dbo].[DimProducts];
DELETE FROM [OlistDW].[dbo].[DimDate];
GO
-- Load Dim Sellers
INSERT INTO DimSellers (
    SellerID, SellerZip, SellerCity, SellerState,
    RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason
)
SELECT
    Seller_id, Seller_zip_code_prefix, Seller_city, Seller_state,
    1, GETDATE(), GETDATE(),'New'
FROM OlistDWStage.dbo.StageSellers;


-- Load Dim Customer
INSERT INTO DimCustomers (
    CustomerID, CustomerUniqueID, CustomerZipCodePrefix,
    CustomerCity, CustomerState,
    RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason,
    InsertAuditKey, UpdateAuditKey
)
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_predix,
    customer_city,
    customer_state,
    1, GETDATE(), GETDATE(), 
    'New',
    NULL, 
    NULL   
FROM OlistDWStage.dbo.StageCustomers;

-- Load Dim Products
INSERT INTO DimProducts (
    ProductID, ProductCategoryName,
    ProductWeight, ProductLength, ProductHeight, ProductWidth,
    RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason,
    InsertAuditKey, UpdateAuditKey
)
SELECT
    product_id,
    product_category_name,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm,
    1, GETDATE(), GETDATE(), 
    'New',
    NULL,
    NULL
FROM OlistDWStage.dbo.StageProducts;


-- Load Dim Geolocation
INSERT INTO DimGeolocation (
    ZipCodePrefix, Latitude, Longitude, City, State,
    RowIsCurrent, RowStartDate, RowEndDate,
    RowChangeReason, InsertAuditKey, UpdateAuditKey
)
SELECT 
    geolocation_zip_code_prefix, geolocation_lat, geolocation_lng,
    geolocation_city, geolocation_state, 1, GETDATE(), GETDATE(),
    'New', NULL, NULL
FROM OlistDWStage.dbo.StageGeolocation;

-- Load Dim Date

INSERT INTO DimDate (
    DateKey,
    Date,
    DayOfWeek,
    DayOfMonth,
    Month,
    MonthName,
    Quarter,
    Year,
    RowIsCurrent,
    RowStartDate,
    RowEndDate,
    RowChangeReason,
    InsertAuditKey,
    UpdateAuditKey
)
SELECT
    date_key,
    full_date,
    day_of_week,
    day_num_in_month,
    month,
    month_name,
    quarter,
    year,
    1,                  
    GETDATE(),         
    NULL,               
    'Loaded from Date', 
    NULL, NULL
FROM [Date].[dbo].[Date_Dimension];


-- Load vào FactPayments
INSERT INTO FactPayments (
    OrderID, CustomerKey, ProductKey, SellerKey, DateKey,
    PaymentType, PaymentInstallments, PaymentValue,
    InsertAuditKey, UpdateAuditKey
)
SELECT
    s.order_id,
    dc.CustomerKey,
    dp.ProductKey,
    ds.SellerKey,
    dd.DateKey,
    s.payment_type,
    s.payment_installments,	
    s.payment_value,
    NULL, NULL
FROM OlistDWStage.dbo.StagePayments s
JOIN DimCustomers dc ON dc.CustomerID COLLATE SQL_Latin1_General_CP1_CI_AS = s.customer_id AND dc.RowIsCurrent = '1'
JOIN DimProducts dp  ON dp.ProductID COLLATE SQL_Latin1_General_CP1_CI_AS = s.product_id AND dp.RowIsCurrent = '1'
JOIN DimSellers ds   ON ds.SellerID COLLATE SQL_Latin1_General_CP1_CI_AS = s.seller_id AND ds.RowIsCurrent = '1'
JOIN DimDate dd      ON dd.Date = CAST(s.order_purchase_timestamp AS DATE) AND dd.RowIsCurrent = '1';


-- Load FactOrderFullFilment
INSERT INTO FactOrderFullFilment (
    CustomerKey, OrderID,
    DeliveryTime, DeliveryDelay, AcceptTime,
    OrderPurchaseTimestampKey,
    OrderApprovedAtKey,
    OrderDeliveredCarrierDateKey,
    OrderDeliveredCustomerDateKey,
    OrderDeliveredEstimateDateKey,
    RowStartDate, RowEndDate
)
SELECT
    dc.CustomerKey,
    s.order_id,
    s.DeliveryTime,
    s.DeliveryDelay,
    s.AcceptTime,
    dp.DateKey,     
    da.DateKey,     
    dca.DateKey,    
    dcu.DateKey,    
    de.DateKey,     
    GETDATE(), GETDATE()
FROM OlistDWStage.dbo.StageOrderFullfilment s
JOIN DimCustomers dc ON dc.CustomerID COLLATE SQL_Latin1_General_CP1_CI_AS = s.customer_id AND dc.RowIsCurrent = 1
JOIN DimDate dp  ON dp.Date = CAST(s.order_purchase_timestamp AS DATE) AND dp.RowIsCurrent = 1
JOIN DimDate da  ON da.Date = CAST(s.order_approved_at AS DATE) AND da.RowIsCurrent = 1
JOIN DimDate dca ON dca.Date = CAST(s.order_delivered_carrier_date AS DATE) AND dca.RowIsCurrent = 1
JOIN DimDate dcu ON dcu.Date = CAST(s.order_delivered_customer_date AS DATE) AND dcu.RowIsCurrent = 1
JOIN DimDate de  ON de.Date = CAST(s.order_delivered_delivery_date AS DATE) AND de.RowIsCurrent = 1;

-- Load FactSalesItem
INSERT INTO [OlistDW].[dbo].[FactSalesItem] (
    OrderID,
    OrderItemID,
    CustomerKey,
    SellerKey,
    ProductKey,
    CustomerGeollocationKey,
    SellerGeolocationKey,
    OrderDateKey,
    Revenue,
    FreightValue,
    GrossProfit,
    InsertAuditKey,
    UpdateAuditKey
)
SELECT
    s.order_id,
    s.order_item_id,
    dc.CustomerKey,
    ds.SellerKey,
    dp.ProductKey,
    dgc.GeoLocationKey AS CustomerGeollocationKey,
    dgs.GeoLocationKey AS SellerGeolocationKey,
    dd.DateKey,
    s.price AS Revenue,
    s.freight_value AS FreightValue,
    s.price - s.freight_value AS GrossProfit,
    NULL AS InsertAuditKey,
    NULL AS UpdateAuditKey
FROM [OlistDWStage].[dbo].[StageSalesItem] s
JOIN [OlistDW].[dbo].[DimCustomers] dc
    ON dc.CustomerID COLLATE SQL_Latin1_General_CP1_CI_AS = s.customer_id
   AND dc.RowIsCurrent = 1
JOIN [OlistDW].[dbo].[DimSellers] ds
    ON ds.SellerID COLLATE SQL_Latin1_General_CP1_CI_AS = s.seller_id
   AND ds.RowIsCurrent = 1
JOIN [OlistDW].[dbo].[DimProducts] dp
    ON dp.ProductID COLLATE SQL_Latin1_General_CP1_CI_AS = s.product_id
   AND dp.RowIsCurrent = 1
JOIN [OlistDW].[dbo].[DimGeolocation] dgc
    ON dgc.ZipCodePrefix = s.customer_zip_code_predix
   AND dgc.RowIsCurrent = 1
JOIN [OlistDW].[dbo].[DimGeolocation] dgs
    ON dgs.ZipCodePrefix = s.seller_zip_code_prefix
   AND dgs.RowIsCurrent = 1
JOIN [OlistDW].[dbo].[DimDate] dd
    ON dd.[Date] = CAST(s.order_purchase_timestamp AS DATE)
   AND dd.RowIsCurrent = 1;

-- Load FactReview
INSERT INTO FactReview (
    ReviewID, OrderID, CustomerKey, ReviewScore,
    DeliveryCost, ReviewAnswerTimestampKey, ReviewCreationDateKey,
    ResponseTime, InsertAuditKey, UpdateAuditKey
)
SELECT
    s.review_id,
    s.order_id,
    dc.CustomerKey,
    s.review_score,
    s.delivery_cost,
    da.DateKey,  
    dcdate.DateKey, 
    s.response_time,
    NULL, NULL
FROM OlistDWStage.dbo.StageReview s
JOIN DimCustomers dc 
    ON dc.CustomerID COLLATE SQL_Latin1_General_CP1_CI_AS = s.customer_id AND dc.RowIsCurrent = 1
JOIN DimDate da 
    ON da.Date = CAST(s.review_answer_timestamp AS DATE) AND da.RowIsCurrent = 1
JOIN DimDate dcdate 
    ON dcdate.Date = CAST(s.review_creation_date AS DATE) AND dcdate.RowIsCurrent = 1;


