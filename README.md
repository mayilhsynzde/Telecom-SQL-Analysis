            Telecom-SQL-Analysis
 Mobile Operator Subscriber & Billing SQL Analysis

     Layihə Haqqında
Bu layihə mobil operator abunəçilərinin demoqrafik göstəricilərini, ödəniş tarixçələrini və aktiv istifadəçi tendensiyalarını təhlil etmək üçün **MS SQL Server** mühitində yazılmış optimallaşdırılmış SQL sorğularından ibarətdir.

     SQL Sorğularının Strukturu
1. **Demoqrafik Təhlil:** Abunəçilərin yaş qrupları (`CASE WHEN`) və cinsiyyət üzrə faiz payının hesablanması.
2. **Ödəniş Trendləri (Billing):** Son 6 ay ərzində ödəniş üsulları üzrə ümumi gəlir və orta ödəniş məbləğlərinin (`SUM`, `AVG`) təhlili.
3. **Aktiv İstifadəçi (ARPU) Analizi:** `INNER JOIN` əməliyyatı vasitəsilə aktiv statuslu abunəçilərin regional paylanması və hər istifadəçiyə düşən orta gəlirin hesablanması.

       İstifadə Olunan Alətlər & Texnologiyalar
- **MS SQL Server / T-SQL**
- **Agregasiya funksiyaları:** `COUNT`, `SUM`, `AVG`, `GROUP BY`, `HAVING`
- **İnteqrasiya:** `INNER JOIN`, `CASE WHEN` şərti operatorları.
