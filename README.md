# ⚡ FitPulse | Advanced Fitness Tracking Engine

**FitPulse** هو تطبيق متطور لتتبع اللياقة البدنية مصمم بأسلوب **Clean Architecture** لضمان الكفاءة والقابلية للتوسع. يوفر التطبيق تجربة مستخدم فريدة تدمج بين تتبع الأنشطة الرياضية، إدارة الأهداف الصحية، وتحليل البيانات الحيوية.

---

## 📸 App Showcase

<details>
<summary>اضغط لمشاهدة لقطات الشاشة (Click to expand screenshots)</summary>

| Dashboard | Real-time Stats | Exercise Library |
|:---:|:---:|:---:|
| <img src="screenshots/home.png" width="220"> | <img src="screenshots/stats.png" width="220"> | <img src="screenshots/exercises.png" width="220"> |

| Active Session | Health Goals | Dark Mode Engine |
|:---:|:---:|:---:|
| <img src="screenshots/active.png" width="220"> | <img src="screenshots/goals.png" width="220"> | <img src="screenshots/settings.png" width="220"> |

</details>

---

## 🛠 Technical Architecture (البنية التقنية)

يعتمد التطبيق على مبادئ برمجية قوية لضمان سهولة الصيانة:

* **State Management:** استخدام `Provider` لإدارة الحالة وتوفير البيانات بشكل فعال عبر الشاشات.
* **Theming Engine:** نظام ديناميكي للتبديل بين الـ Dark/Light Mode مع الحفاظ على تجربة بصرية مريحة.
* **Navigation:** نظام Routing منظم لتسهيل التنقل بين الشاشات المعقدة.
* **Custom Painting & UI:** استخدام Custom Shapes و Widgets مخصصة لتمثيل الرسوم البيانية (Statistics Charts).

---

## 🚀 Key Features (المميزات الرئيسية)

### 🏃‍♂️ Workout Management
- مكتبة تمارين شاملة مصنفة حسب العضلات المستهدفة.
- واجهة تمرين نشطة (Active Workout) تتبع المجموعات والوقت والسعرات بدقة.

### 📊 Advanced Analytics
- رسوم بيانية توضح النشاط الأسبوعي.
- تحليل توزيع التمارين (Breakdown) لمعرفة التركيز العضلي للمستخدم.

### 🎯 Goal Oriented System
- تتبع شرب الماء، الخطوات اليومية، والوزن المستهدف باستخدام Sliders تفاعلية.
- مؤشر كتلة الجسم (BMI) مع تحليل تلقائي للحالة الصحية.

---
<img width="390" height="853" alt="Screenshot 2026-05-15 203822" src="https://github.com/user-attachments/assets/c25d17de-faeb-4f31-a1d8-607f84d57aa1" />
<img width="391" height="858" alt="Screenshot 2026-05-15 202503" src="https://github.com/user-attachments/assets/5bdae4c8-555f-4c87-b755-65e34fecb738" />
<img width="391" height="859" alt="Screenshot 2026-05-15 202434" src="https://github.com/user-attachments/assets/98e8dd06-65f2-4b69-8b3c-25a815a21387" />
<img width="392" height="856" alt="Screenshot 2026-05-15 202419" src="https://github.com/user-attachments/assets/7d0b1cb9-8741-4392-a402-7fb5e77ad638" />
<img width="398" height="858" alt="Screenshot 2026-05-15 202330" src="https://github.com/user-attachments/assets/d5717197-e2fa-450d-b77d-f493898312ee" />
<img width="393" height="858" alt="Screenshot 2026-05-15 202309" src="https://github.com/user-attachments/assets/bf658af8-2502-43eb-9af1-c1d2be63e74d" />
<img width="392" height="857" alt="Screenshot 2026-05-15 202245" src="https://github.com/user-attachments/assets/700637dc-e13d-4e0f-9315-eec956f672a9" />
<img width="393" height="853" alt="Screenshot 2026-05-15 202232" src="https://github.com/user-attachments/assets/40af8ef8-2c75-48f5-b869-01b5449e5c87" />
<img width="389" height="855" alt="Screenshot 2026-05-15 202213" src="https://github.com/user-attachments/assets/43f761da-35c6-4c55-bd04-e7e632e58f97" />
<img width="392" height="848" alt="Screenshot 2026-05-15 202044" src="https://github.com/user-attachments/assets/09488ca1-8e62-4618-804d-7d4fff8f5c34" />


## 🏗 Project Folder Structure

```text
lib/
 ├── core/
 │    ├── theme/      # App Colors, ThemeProvider
 │    └── utils/      # Constants, Helpers
 ├── models/          # Data Models (Exercise, UserStats)
 ├── screens/         # Feature-based UI Screens
 ├── widgets/         # Reusable UI Components (Cards, Buttons)
 └── app.dart         # Main Application Entry & Routes
