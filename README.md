# Microsoft Entra ID (Azure AD) IAM Implementation: DemoBank
---

## Table of Contents
1. [Overview](#overview)
2. [Key Objectives](#key-objectives)
3. [Architecture & Services](#architecture--services)
4. [Implementation](#implementation)
   - [Phase 1 – RBAC + MFA (Basics)](#phase-1—rbac--mfa-basics)
   - [Phase 2 – Terraform IaC](#phase-2—terraform-iac)
   - [Phase 3 – Privileged Identity Management (PIM) + Microsoft Sentinel Integration](#phase-3—privileged-identity-management-pim)
5. [User / Group Matrix](#user--group-matrix)
6. [Testing & Validation](#testing--validation)
7. [Challenges & Lessons](#challenges--lessons)
8. [Screenshots](#screenshots)
9. [Conclusion](#conclusion)

---

## Overview
DemoBank (fictional FinTech) needed to:  
* eliminate always‑on admin rights,  
* enforce MFA,  
* utomate user and group management using Infrastructure as Code (IaC),
* enable real-time monitoring of privileged role activations.  

A new tenant was spun up with an **Azure AD Premium P2 trial** to unlock **Privileged Identity Management (PIM)**.  
Terraform drives repeatable user & group creation; PIM supplies just‑in‑time (JIT) admin access.

---

## Key Objectives
| Phase | Goal | Outcome |
|-------|------|---------|
| 1 |Baseline groups, users, MFA & RBAC | ✅ Completed |
| 2 |Provision users & groups via **Terraform** | ✅ Completed |
| 3 |Enable **PIM** with Sentinel monitoring – JIT roles, MFA on activation, full audit trail | ✅ Completed |

---

  ## Architecture & Services
* **Microsoft Entra ID (Azure AD)** – directory, groups, roles  
* **Azure AD Premium P2** – Privileged Identity Management  
* **Terraform + azuread provider** – Infrastructure‑as‑Code  
* **Microsoft Sentinel** – real-time security monitoring
* **Security Defaults / per‑user MFA** – strong auth
* **Audit & Sign‑in logs** – evidence & troubleshooting

---

## Implementation

### Phase 1 — RBAC + MFA (Basics)
1. Created five functional groups: `DataTeam`, `Operations`, `Security`, `DevOpsTeam`, `Compliance`.  
2. Added initial users; mapped RBAC roles (Reader / Contributor) at RG‑DemoBank level.  
3. Enforced MFA via Security Defaults & per‑user MFA.  
4. Verified sign‑in logs & basic auditing.

### Phase 2 — Terraform IaC
| Step | Highlights |
|------|------------|
| Install Terraform | Local PowerShell + Azure CLI token from `az login` |
| `main.tf` | 2 new users (`Erika`, `Anthony`) • role‑assignable group (`Helpdesk`) |
| `terraform init / apply` | Idempotent user + group provisioning |

### Phase 3 — Privileged Identity Management (PIM) + Microsoft Sentinel Integration
| Action | Detail |
|--------|--------|
| Enable PIM | Premium P2 trial activated in the new tenant + Integrated PIM audit logs into Microsoft Sentinel for real-time monitoring |
| Role policies | 1‑hour activation • MFA required • justification logged |
| Eligible assignments | `Security` ➜ *Security Administrator* • `Compliance` ➜ *Compliance Administrator* |
| JIT activation test | Annie (Security) activates role, passes MFA, gains admin rights for 60 min |
| Audit trail | Activation events recorded in **PIM → Audit History** + AzureAD Audit Logs |

---

## User / Group Matrix

| User | Job Title | Group (Entra ID) | Role (Entra ID) | PIM Mode |
|------|-----------|------------------|-----------------|----------|
| Alicia | Data Analyst | DataTeam | — | — |
| Miguel | Branch Teller | Operations | — | — |
| Annie | Security Admin | Security | Security Administrator | **Eligible** |
| Mark | Developer | DevOpsTeam | — | — |
| Jesus | Compliance Mgr | Compliance | Compliance Administrator | **Eligible** |
| Erika | Helpdesk | Helpdesk | — | — |
| Anthony | Helpdesk | Helpdesk | — | — |


---

## Testing & Validation
1. **Terraform drift‑free**: `terraform plan` returns “No changes” after apply.  
2. **PIM JIT**: role activation prompts MFA; auto‑expires at 60 min.  
3. **Audit**: every activation appears in *PIM → Audit History* with requester, duration, justification.
4. **Sentinel Integration**: Verified real-time detection and incident creation within 5 minutes of PIM activations 
5. **Least Privilege**: Non‑privileged users cannot elevate without group membership.

---

## Challenges & Lessons
* **Tenant separation** – had to recreate resources in a new P2‑enabled tenant.  
* **Cloud Shell blocked** (no sub) → switched to local PowerShell + Azure CLI.  
* **Terraform resource names must be unique** – duplicate names trigger init errors.
* **Integration Complexity**: Understanding and correctly configuring Sentinel's integration with Azure AD audit logs was critical.

---

## Screenshots
Below are a few key screenshots demonstrating the process:

| Screenshot | Caption |
|------------|---------|
| Groups & members | Post‑Terraform groups in Entra ID |
| PIM settings | 1‑hour activation, MFA required |
| Role desactivation | Annie desactivating Security Admin |
| PIM audit log | Activation recorded with justification |

All images are located in this repo.

<div style="display: flex; flex-direction: row;">
  <img  style="margin-bottom: 10px;" src="https://github.com/GabrielaArjona/azure-iam-demobank/blob/dfe3736fb2b4071c6f4e2fe1a5beb55f9028de3f/groups_post_terraform.png" alt="project" width="350" height="250">
  <img  style="margin-bottom: 10px;" src="https://github.com/GabrielaArjona/azure-iam-demobank/blob/dfe3736fb2b4071c6f4e2fe1a5beb55f9028de3f/PIM_settings.png" width="350" height="250">
  <img  style="margin-bottom: 10px;" src="https://github.com/GabrielaArjona/azure-iam-demobank/blob/dfe3736fb2b4071c6f4e2fe1a5beb55f9028de3f/PIM_activation.png" width="350" height="200">
  <img  style="margin-bottom: 10px;" src="https://github.com/GabrielaArjona/azure-iam-demobank/blob/dfe3736fb2b4071c6f4e2fe1a5beb55f9028de3f/Annie_audit.png" width="350" height="250">

</div>

---

## Conclusion & Next Step
DemoBank now runs on a **least‑privilege, auditable IAM model**:

* **Terraform** delivers repeatable, version‑controlled identities.  
* **PIM** removes standing admin rights, enforces MFA, and logs every elevation.  

**Future work**  
* Integrate Sentinel for SIEM alerts on PIM activations.

---
