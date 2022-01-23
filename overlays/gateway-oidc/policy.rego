package httpapi.authz

import input

import data["statcan.gc.ca"].daaas.profiles

default allow = false

rl_permissions := {
    "reader": [
        {"action": "s3:ListBucket"},
        {"action": "s3:GetObject"},
        {"action": "s3:ListAllMyBuckets"},
    ],
    "user": [
        {"action": "s3:CreateBucket"},
        {"action": "s3:DeleteBucket"},
        {"action": "s3:DeleteObject"},
        {"action": "s3:GetObject"},
        {"action": "s3:ListAllMyBuckets"},
        {"action": "s3:GetBucketObjectLockConfiguration"},
        {"action": "s3:ListBucket"},
        {"action": "s3:PutObject"},
    ],
    "shared": [
        {"action": "s3:ListAllMyBuckets"},
        {"action": "s3:GetObject"},
        {"action": "s3:ListBucket"},
    ],
}

##
## PRIVATE BUCKETS
##

# Allow access from OIDC
allow {
    profiles[input.bucket][_] == input.claims.preferred_username
    permissions := rl_permissions.user
    p := permissions[_]
    p == {"action": input.action}
}

##
## SHARED BUCKET
##

# Allow access from OIDC
allow {
    input.bucket == "shared"

    profiles[profile][_] == input.claims.preferred_username
    url := concat("/", [profile, ".*$"])
    re_match(url, input.object)

    permissions := rl_permissions.user
    p := permissions[_]
    p == {"action": input.action}
}

# Allow other shared permissions to all users
allow {
    input.bucket == "shared"
    permissions := rl_permissions.shared
    p := permissions[_]
    p == {"action": input.action}
}
