---
title: Split
categories: intrinsic-function
nav_order: 43
---

The `split` method is the CloudFormation [Fn::Split](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference-split.html) equivalent.

## Example Snippet

```ruby
resource(:instance, "AWS::EC2::Instance",
  instance_type: ref(:instance_type),
  image_id: "ami-0de53d8956e8dcf80",
  security_group_ids: split(",", ref(:security_groups))
)
```

## Example Output

```yaml
Resources:
  Instance:
    Type: AWS::EC2::Instance
    Properties:
      InstanceType:
        Ref: InstanceType
      ImageId: ami-0de53d8956e8dcf80
      SecurityGroupIds:
        Fn::Split:
        - ","
        - Ref: SecurityGroups
```

{% include back_to/intrinsic_functions.md %}

{% include prev_next.md %}