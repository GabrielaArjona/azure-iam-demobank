# Microsoft Entra ID (Azure AD) IAM Implementation: DemoBank

**Project Context**  
DemoBank is a growing FinTech company that needs an IAM (Identity and Access Management) solution to streamline user access, reduce unnecessary privileges, and improve security. **Entra ID** was chosen to handle user identities, roles, and MFA.

## Table of Contents
1. [Overview](#overview)
2. [Objectives](#objectives)
3. [Architecture & Services Used](#architecture--services-used)
4. [Implementation Steps](#implementation-steps)
   - [A. Create Entra ID Groups](#a-create-entra-id-groups)
   - [B. Create and Add Users](#b-create-and-add-users)
   - [C. Create Resource Group](#c-create-resource-group)
   - [D. RBAC Role Assignments](#d-rbac-role-assignments)
   - [E. Configure MFA](#e-configure-mfa)
   - [F. Basic Audit & Reporting](#f-basic-audit--reporting)
5. [Testing](#testing)
6. [Challenges & Lessons Learned](#challenges--lessons-learned)
7. [Screenshots](#screenshots)
8. [Conclusion](#conclusion)

---

## Overview
DemoBank had issues with users retaining access after role changes and a lack of MFA. By implementing Azure AD and enforcing an RBAC model, we reduced security risks and streamlined identity management.

---

## Objectives
1. Set up **Microsoft Entra ID (Azure AD)** with appropriate **groups** and **users**.  
2. Implement **RBAC** at the resource group level.  
3. Enforce **MFA** for all or specific users.  
4. Perform **basic auditing** of sign-ins and role changes.

---

## Architecture & Services Used
- **Microsoft Entra ID (Azure AD)**: For user and group management.  
- **Azure Resource Group**: DemoBank resource group (`DemoBank`).  
- **Role-Based Access Control (RBAC)**: Reader, Contributor roles assigned to different groups.  
- **MFA**: Used default security settings and per-user MFA.  
- **Audit logs & Sign-in logs**: For monitoring and troubleshooting.

---

## Implementation Steps

### A. Create Entra ID Groups
1. In Microsoft Entra ID, go to **Groups** > **New group**.  
2. Created groups like `DevOps Team`, `Compliance`, etc.  
3. Stored each group’s membership logic.

### B. Create and Add Users
1. Created new Entra ID users (e.g., `alicia@...`, `mark@...`).  
2. Assigned each user a role/title (Analyst, DevOps, etc.).  
3. Added them to the relevant groups.

### C. Create Resource Group
1. Under **Resource Groups**, clicked **Create**.  
2. Named it `DemoBank`.  
3. Chose the subscription and region.

### D. RBAC Role Assignments
1. In `DemoBank` > **Access control (IAM)** > **Add role assignment**.  
2. Assigned **Reader** to `Compliance` group, **Contributor** to `DevOpsTeam`, etc.  
3. Verified that users inherited the correct permissions from their group memberships.

#### User-to-Role Table

| **User** | **Job**                    | **Group Azure AD** | **RBAC in RG-DemoBank** |
|----------|----------------------------|--------------------|-------------------------|
| Alicia   | Data Analyst              | DataTeam           | Contributor             |
| Miguel   | Branch Teller             | Operations         | Reader                  |
| Annie    | Security Administrator    | Security           | Owner                   |
| Mark     | Developer                 | DevOpsTeam         | Contributor             |
| Jesus    | Compliance Manager        | Compliance         | Reader                  |


### E. Configure MFA
- Since Conditional Access wasn’t available in our subscription, we used:
  - **Per-user MFA** 
  - **Security Defaults** (which automatically enforces MFA for all users).
- Ensured each user had to register a second factor (phone, Authenticator app).

### F. Basic Audit & Reporting
1. Opened **Entra ID** > **Sign-in logs** to see who logged in and from where.  
2. Filtered by user (e.g., Alicia) to confirm:
   - Password changed successfully.
   - MFA prompt was triggered.
   - Same IP used consistently.

---

## Testing
1. **Login Test**: Verified that users in `DataTeam` could create resources (Contributor), while `Compliance` group members could only view them (Reader).  
2. **MFA Enforcement**: Verified that each user was prompted to set up MFA on their next sign-in.  
3. **Audit Logs**: Confirmed sign-in logs displayed the correct IP and showed MFA prompt status.

---

## Challenges & Lessons Learned
- **Conditional Access** requires a higher tier license or trial; we used per-user MFA instead.  
- **Security Defaults** sometimes automatically enforces MFA. It’s simpler but less customizable.  
- **RBAC** can be confusing at first; always verify group memberships and scopes.  
- **Documentation** with screenshots and step-by-step notes helps track changes and makes debugging easier.

---

## Screenshots
Below are a few key screenshots demonstrating the process:

| Screenshot | Description |
|------------|------------|
| **Screenshot 1** | Groups created in Entra ID (e.g., `DevOpsTeam`, `Compliance`). |
| **Screenshot 2** | Resource Group `DemoBank` details and Access Control (IAM) assignments. |
| **Screenshot 3** | MFA Enforcement. |
| **Screenshot 4** | Sign-in logs showing success with MFA, Expired Password, IP address, and user details. |

All images are located in this repo.

<div style="display: flex; flex-direction: row;">
  <img  style="margin-bottom: 10px;" src="https://github.com/GabrielaArjona/azure-iam-demobank/blob/5f8f6a8d8f901d9b7909e121db44d0b085db84b3/EntraID_groups.png" alt="project" width="350" height="250">
  <img  style="margin-bottom: 10px;" src="https://github.com/GabrielaArjona/azure-iam-demobank/blob/5f8f6a8d8f901d9b7909e121db44d0b085db84b3/EntraID_RG_DemoBank.png" width="350" height="250">
  <img  style="margin-bottom: 10px;" src="https://github.com/GabrielaArjona/azure-iam-demobank/blob/5f8f6a8d8f901d9b7909e121db44d0b085db84b3/EntraID_MFA.png" width="350" height="200">
  <img  style="margin-bottom: 10px;" src="https://github.com/GabrielaArjona/azure-iam-demobank/blob/5f8f6a8d8f901d9b7909e121db44d0b085db84b3/EntraID_audit.png" width="350" height="250">

</div>

---

## Conclusion
With **Entra ID** and a basic **RBAC + MFA** setup, DemoBank now has a more secure IAM environment. Users only get the privileges they need, and MFA greatly reduces the risk of unauthorized access. The next step could be exploring advanced conditional access or enabling Privileged Identity Management (PIM) for elevated roles.

---
