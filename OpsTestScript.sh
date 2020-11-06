#!/bin/bash
#Author: Sneha Vasudeva Rao
#Date: 10/19/2020
#Purpose: check if architecture is working as expected


ansible-playbook OpsScript.yml
ansible-playbook  DBOpsScript.yml 
ansible-playbook LBOpsScript.yml

