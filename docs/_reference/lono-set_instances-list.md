---
title: lono set_instances list
reference: true
---

## Usage

    lono set_instances list STACK_SET

## Description

List CloudFormation stack set instances.

## Example

    $ lono set_instances list my-set
    Stack Instance: account 112233445566 region ap-northeast-1 status CURRENT
    Stack Instance: account 223344556677 region us-west-1 status CURRENT
    Stack Instance: account 223344556677 region ap-northeast-1 status CURRENT
    Stack Instance: account 223344556677 region us-west-2 status CURRENT
    Stack Instance: account 223344556677 region ap-northeast-2 status CURRENT
    Stack Instance: account 112233445566 region ap-northeast-2 status CURRENT
    Stack Instance: account 112233445566 region us-west-2 status CURRENT
    Stack Instance: account 112233445566 region us-west-1 status CURRENT
    Time took to complete stack set operation: 4m 29s
    Stack set operation completed.
    $



