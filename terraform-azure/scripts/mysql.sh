#!/bin/bash


kubectl exec -i service/mysql -- mysql -u root -p1234 -e "show databases;"
