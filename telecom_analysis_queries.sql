            -- MOBİL OPERATOR MƏLUMATLARININ SQL İLƏ TƏHLİLİ (TELECOM DATA ANALYSIS)
            -- Təhlil Edən: Mayıl Hüseynzadə
            -- Dialekt: T-SQL / MS SQL Server

      -- 1. ABUNƏÇİLƏRİN DEMOQRAFİK VƏ YAŞ QRUPLARI ÜZRƏ BÖLÜNMƏSİ
-- Məqsəd: Müştəri bazasının yaş kateqoriyalarına görə strukturunu müəyyən etmək.
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25 (Gənc)'
        WHEN Age BETWEEN 26 AND 40 THEN '26-40 (Aktiv)'
        WHEN Age BETWEEN 41 AND 60 THEN '41-60 (Yetkin)'
        ELSE '60+ (Yaşlı)'
    END AS AgeGroup,
    Gender,
    COUNT(SubscriberID) AS TotalSubscribers,
    ROUND(CAST(COUNT(SubscriberID) AS FLOAT) * 100 / SUM(COUNT(SubscriberID)) OVER(), 2) AS PercentageShare
FROM 
    SubscribersDemographics
GROUP BY 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25 (Gənc)'
        WHEN Age BETWEEN 26 AND 40 THEN '26-40 (Aktiv)'
        WHEN Age BETWEEN 41 AND 60 THEN '41-60 (Yetkin)'
        ELSE '60+ (Yaşlı)'
    END,
    Gender
ORDER BY 
    TotalSubscribers DESC;


      -- 2. SON ÖDƏNİŞ TARİXLƏRİ VƏ ÖDƏNİŞ ÜSULLARI ÜZRƏ TƏHLİL (PAYMENT TRENDS)
-- Məqsəd: Abunəçilərin istifadə etdikləri ödəniş üsullarını və ümumi daxilolmaları hesablamaq.
SELECT 
    PaymentMethod,
    COUNT(TransactionID) AS TotalTransactions,
    SUM(PaymentAmount) AS TotalRevenue,
    ROUND(AVG(PaymentAmount), 2) AS AvgTransactionAmount
FROM 
    BillingHistory
WHERE 
    PaymentDate >= DATEADD(month, -6, GETDATE()) -- Son 6 ayın məlumatları
GROUP BY 
    PaymentMethod
ORDER BY 
    TotalRevenue DESC;


      -- 3. AKTİV İSTİFADƏÇİLƏRİN SAYI VƏ ÜMUMİ ÖDƏNİŞ MƏBLƏĞİNİN HESABLANMASI
-- Məqsəd: Statusu 'Active' olan abunəçilərin operator üzrə ümumi dəyərini (ARPU analizi) tapmaq.
SELECT 
    s.Region,
    COUNT(DISTINCT s.SubscriberID) AS ActiveSubscribersCount,
    SUM(b.PaymentAmount) AS TotalPaidAmount,
    ROUND(SUM(b.PaymentAmount) / NULLIF(COUNT(DISTINCT s.SubscriberID), 0), 2) AS ARPU_AverageRevenuePerUser
FROM 
    SubscribersDemographics s
INNER JOIN 
    BillingHistory b ON s.SubscriberID = b.SubscriberID
WHERE 
    s.AccountStatus = 'Active'
GROUP BY 
    s.Region
ORDER BY 
    TotalPaidAmount DESC;
