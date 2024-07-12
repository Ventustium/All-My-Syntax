#!/bin/bash

bucket_name="$1"
password="$2"

policy=$(cat <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:GetBucketLocation",
                "s3:ListBucket"
            ],
            "Effect": "Allow",
            "Principal": "*",
            "Resource": "arn:aws:s3:::${bucket_name}"
        },
        {
            "Action": [
                "s3:*"
            ],
            "Effect": "Allow",
            "Principal": "*",
            "Resource": "arn:aws:s3:::${bucket_name}/*"
        }
    ]
}
EOF
)

output_file="minio/policy/${bucket_name}.json"
echo "$policy" > "$output_file"
echo "MinIO policy saved to $output_file"

./mc admin policy create myminio ${bucket_name} $output_file
./mc admin user add myminio ${bucket_name} ${password}
./mc admin policy attach myminio ${bucket_name} --user ${bucket_name}
