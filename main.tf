# TERRAFORM provider block

terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.47.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "azuread" {
  # Tokens from "az login" Will be re-use
}



# Create users

# 1. Erika
resource "azuread_user" "erika" {
	display_name = "Erika"
	user_principal_name = "erika@mytenant"
	mail_nickname = "erika"
	password = "Pa$$w0rd123***"
	force_password_change = true	
}

# 2. Anthony
resource "azuread_user" "anthony" {
	display_name = "Anthony"
	user_principal_name = "anthony@mytenant"
	mail_nickname = "anthony"
	password = "Pa$$w0rd123***"
	force_password_change = true
}



###############



# Create a group
resource "azuread_group" "helpdesk" {
	display_name = "Helpdesk"
	security_enabled = true
	assignable_to_role = true
}



###############



# Add users to Helpdesk

# 1. Erika

resource "azuread_group_member" "helpdesk_erika" {
	group_object_id = azuread_group.helpdesk.id
	member_object_id = azuread_user.erika.object_id
}

# 2. Anthony

resource "azuread_group_member" "helpdesk_anthony" {
	group_object_id = azuread_group.helpdesk.id
	member_object_id = azuread_user.anthony.object_id
}
