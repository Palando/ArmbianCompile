#!/bin/bash

terraform apply -var hcloud_token=$HCLOUD_TOKEN -auto-approve
