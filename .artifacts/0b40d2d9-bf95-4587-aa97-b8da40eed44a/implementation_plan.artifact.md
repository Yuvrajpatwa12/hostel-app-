# Implementation Plan - Student Info & Fee Ledger

I will upgrade the **Fee Management Screen** into a comprehensive **Student Info Center**. Admins will be able to search for any student by email and view their complete signup details alongside their full payment history.

## User Review Required

> [!IMPORTANT]
> **Data Privacy**: This screen will now expose all student details (Parents, LG, Health, etc.) to the Admin.

## Proposed Changes

### 1. Backend Updates (PHP)
- **[MODIFY] `api/search_student.php`**: Upgrade query from `SELECT id, name...` to `SELECT *` to return every field from the `users` table.
- **[MODIFY] `api/get_fee_status.php`**: Ensure it correctly returns both `history` and calculated `upcoming` dues for the admin's search result.

### 2. API Service (Flutter)
- **[MODIFY] [api_service.dart](file:///C:/Users/yuraj/AndroidStudioProjects/kathmadnuhostel/lib/screens/admin/api_service.dart)**:
    - Ensure `searchStudentByEmail` returns the full map of user data.

### 3. Fee Management UI Redesign
- **[MODIFY] [fee_management_screen.dart](file:///C:/Users/yuraj/AndroidStudioProjects/kathmadnuhostel/lib/screens/admin/fee_management_screen.dart)**:
    - **Header**: Attractive profile summary (Avatar, Name, Status, Join Date).
    - **Section 1: Fee Ledger**: A scrollable history of "Paid Months" vs "Pending Months".
    - **Section 2: Personal Dossier**: An attractive, organized grid showing:
        - Educational Details (Institute, Class Time, Level).
        - Address (District, Ward, Street).
        - Health (Diseases, Food Preference).
    - **Section 3: Guardian Details**: Dedicated cards for Father, Mother, and Local Guardian with contact numbers.

## Verification Plan

### Manual Verification
1.  **Search**: Enter a student's email.
2.  **Profile**: Verify all fields (like LG Name, Class Time) are visible and correctly labeled.
3.  **Ledger**: Verify the payment history matches the `fees` table records.
4.  **Transaction**: Record a new payment and verify the UI updates to show it in the history immediately.
