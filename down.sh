#!/bin/bash

terraform destroy -var hcloud_token=$HCLOUD_TOKEN -auto-approve
