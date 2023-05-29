terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.8.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "workflow-resources"
  location = "West Europe"
}

resource "azurerm_template_deployment" "example" {
  name                = "logic-app-01"
  resource_group_name = azurerm_resource_group.example.name

  //given the logic app ARM is added into same directory where you have this code.
  template_body = file("${path.module}/logicapp_arm.json")

  //ARM template code can be found here: https://gist.github.com/ab713fc2f4d37105cfa88d8b7966e76c.git

  parameters = {
    logicappName = "logic-app-01"
  }
  deployment_mode = "Incremental"
}