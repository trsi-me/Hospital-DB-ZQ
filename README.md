# Hospital DB - ZQ

## 1. ما هو المشروع؟

سكربت SQL في `project.sql` لمخطط مستشفى بأسماء جداول إنجليزية مختلفة عن نسخة FO، مع تقرير `hospital_report_complete.docx` و`hospital_report_complete.pdf` وصورة `images/ER-digrem.png` ولقطات في `images/screenshots`. تطبيق تشغيل غير موجود.

## 2. لماذا يوجد هذا المشروع؟

استنتاج من الكود: نفس فكرة بيانات المستشفى (تغطية، عملاء، أطباء، مقدمو رعاية، تنويم، مواعيد، تشخيص، نتائج، أدوية، وصفات) بأسماء أعمدة أخرى.

## 3. من يستخدمه؟

من ينفّذ SQL. واجهة مستخدم داخل المجلد غير موجودة.

## 4. ماذا يستطيع النظام أن يفعل؟

إنشاء الجداول COVERAGES وCLIENTS وDOCTORS وCAREGIVERS وHOSPITALIZATIONS وSCHEDULES وDIAGNOSTICS وDIAG_RESULTS وDRUGS وPRESCRIPTIONS ثم INSERT. عدد جداول الإنشاء 10.

## 5. كيف يعمل النظام؟

تشغيل `project.sql` من قسم CREATE TABLES ثم الإدراج. استعلامات SELECT بنفس أسلوب ملف FO غير ظاهرة في رأس الملف الذي قُرئ؛ الجمل الموجودة CREATE وINSERT.

## 6. أمثلة واقعية

بعد التنفيذ يصبح لكل عميل CoverageID يشير إلى COVERAGES. التنويم HospID يربط ClientID وAttendingDoc. الوصفة RXID تربط عميلاً وطبيباً ودواء. صفوف الإدراج غير منسوخة هنا.

## 7. رحلة المستخدم

فتح عميل SQL وتشغيل `project.sql`. لقطات الشاشة في `images/screenshots` مرقمة من 2255 إلى 2264.

## 8. الوحدات والأقسام

| الجدول | المفتاح | علاقة |
| --- | --- | --- |
| COVERAGES | CoverageID | ProviderName, LimitAmount |
| CLIENTS | ClientID | FK CoverageID |
| DOCTORS | DoctorID | Specialty, EmailAddr |
| CAREGIVERS | CaregiverID | ShiftType والقيم في التعليق Day أو Night |
| HOSPITALIZATIONS | HospID | ClientID وAttendingDoc نحو DOCTORS |
| SCHEDULES | ScheduleID | ClientID وDoctorID وStatus |
| DIAGNOSTICS | TestCode | TestLabel, TestInfo |
| DIAG_RESULTS | ResultCode | TestCode وClientID |
| DRUGS | DrugCode | Strength, AdminRoute, Schedule |
| PRESCRIPTIONS | RXID | ClientID وDoctorID وDrugCode |

## 9. الشركات والكيانات

غير موجود في الملفات الحالية كمجموعة شركات. المخطط كيان واحد.

## 10. الصلاحيات

GRANT وأدوار غير موجودة في `project.sql`.

## 11. الأتمتة وWorkflows

إجراءات ومحفزات غير موجودة.

## 12. التكامل بين الوحدات

العميل يرتبط بالتغطية. التنويم والجدول والنتائج والوصفات ترتبط بالعميل. الطبيب يرتبط بالتنويم والمواعيد والوصفات. النتيجة ترتبط بالتشخيص. الوصفة ترتبط بالدواء. CAREGIVERS بلا FK وارد في الملف.

## 13. المصطلحات

| المصطلح في ZQ | مقابل المفهوم |
| --- | --- |
| CLIENTS | العملاء / المرضى |
| COVERAGES | التغطية |
| CAREGIVERS | مقدمو الرعاية |
| HOSPITALIZATIONS | التنويم |
| SCHEDULES | المواعيد |
| DIAGNOSTICS | الفحوصات |
| DRUGS | الأدوية |
| ER-digrem.png | اسم ملف الصورة كما هو |

## 14. الأسئلة الشائعة

**هل هذا تطبيق مستشفى؟** سكربت وملفات تقرير وصور. برنامج واجهة غير موجود.

**هل الأسماء تطابق مجلد FO؟** أسماء الجداول مختلفة. الفكرة العلائقية متقاربة.

## 15. Architecture

```
project.sql -> 10 tables -> INSERT
images/ER-digrem.png
images/screenshots
hospital_report_complete.docx / pdf
```

## 16. Tech Stack

SQL قياسي بالأنواع CHAR وVARCHAR وINT وDATE وFOREIGN KEY. المحرك غير مسمى. مستندات وصورة.

## 17. Project Structure

```
Hospital DB - ZQ/
  project.sql
  hospital_report_complete.docx
  hospital_report_complete.pdf
  images/ER-digrem.png
  images/screenshots/*.png
```

## 18. Frontend

HTML غير موجود. العرض عبر ملفات الصور والتقرير.

## 19. Backend

غير موجود في الملفات الحالية.

## 20. Request Flow

```
SQL client -> project.sql -> tables and inserted rows
```

## 21. Database

سكربت علائقي بلا CREATE DATABASE وبلا سلسلة اتصال. المفاتيح في جدول القسم 8. البذور جمل INSERT داخل `project.sql`.

## 22. API

غير موجود في الملفات الحالية.

## 23. Authentication & Authorization

غير موجود في الملفات الحالية.

## 24. Security

مفاتيح أساسية وأجنبية وNOT NULL. واجهة إدخال مستخدم غير موجودة فلا توجد استعلامات مبنية من مدخلات خارج الملف.

## 25. Configuration

الاتصال غير موثق. التعريف كله في `project.sql`.

## 26. Integrations

غير موجود في الملفات الحالية.

## 27. Scheduled Jobs

غير موجود في الملفات الحالية.

## 28. File Storage

التقرير والصورة واللقطات ملفات في المجلد.

## 29. Logging & Monitoring

تدقيق برمجي غير موجود.

## 30. Installation

شغّل `project.sql` في عميل SQL يقبل القيود المكتوبة. بيانات الخادم غير موثقة.

## 31. Development Guide

أضف جدولاً في الملف مع FK إلى المفاتيح الحالية إن لزم. طبقة تطبيق غير موجودة.

## 32. Deployment

غير موجود في الملفات الحالية.

## 33. Backup & Recovery

استعادة المخطط تتم بإعادة تشغيل `project.sql` على قاعدة فارغة مناسبة. أداة نسخ مجدولة غير موجودة.

## 34. Troubleshooting

فشل المفتاح الأجنبي يعني أن الجدول الأب لم يُنشأ قبل الابن. ترتيب الملف الحالي يبدأ بـ COVERAGES ثم CLIENTS.

## 35. Dependencies

حزم لغة غير موجودة. `project.sql` حوالي 12 كيلوبايت.

## 36. Known Limitations

محرك القاعدة غير موثق. CAREGIVERS بلا علاقات من الجداول الأخرى. اسم الصورة ER-digrem كما في الملف. تطبيق غير موجود.

## 37. Current System State

| الحالة | التفصيل |
| --- | --- |
| موجود | SQL وتقرير كامل وصور |
| غير موجود | تطبيق |
| غير موثق | المحرك |

## 38. Architecture Decisions

استنتاج من الكود: أسماء الجداول مختارة بصيغة إنجليزية بديلة (CLIENTS بدل Patients) داخل ملف واحد.

## 39. سجل التغييرات

سجل إصدارات غير موجود في الملفات الحالية.

## System Overview

```
COVERAGES -> CLIENTS
DOCTORS -> HOSPITALIZATIONS / SCHEDULES / PRESCRIPTIONS
DIAGNOSTICS -> DIAG_RESULTS
DRUGS -> PRESCRIPTIONS
CAREGIVERS مستقل في الملف
```

## Quick Reference

| الجزء | التقنية | الموقع | الوظيفة |
| --- | --- | --- | --- |
| المخطط | SQL | project.sql | عشر جداول وإدراج |
| التقرير | docx/pdf | hospital_report_complete.* | تقرير |
| الرسم | PNG | images/ER-digrem.png | صورة |
| اللقطات | PNG | images/screenshots | 2255-2264 |

## Quick Start

نفّذ `project.sql` في عميل SQL.

## For Non-Technical Users

ملف قاعدة لمستشفى بأسماء جداول مثل CLIENTS وDOCTORS. التشغيل بتشغيل SQL. تطبيق شاشات غير موجود.

## For Developers

العلاقات في `project.sql`. قارن الأسماء مع مجلد Hospital DB - FO عند الحاجة؛ الملفات مختلفة.
