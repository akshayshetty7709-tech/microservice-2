output "master_node_ip"   { value = module.ec2.master_public_ip }
output "worker_node_ips"  { value = module.ec2.worker_public_ips }
output "s3_bucket_name"   { value = module.s3_cloudfront.bucket_name }
output "cloudfront_url"   { value = module.s3_cloudfront.cloudfront_url }
