resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.base_name}-tfstate"

  tags = {
    Name = "${var.base_name}-tfstate"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl
resource "aws_s3_bucket_ownership_controls" "tfstate" {
  bucket = aws_s3_bucket.tfstate.bucket
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "tfstate" {
  depends_on = [aws_s3_bucket_ownership_controls.tfstate]
  bucket     = aws_s3_bucket.tfstate.bucket
  acl        = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "tfstate" {
  bucket = aws_s3_bucket.tfstate.bucket
  /*   S3がこのバケットのパブリックACLをブロックする必要があるか。デフォルトはfalseです。
  この設定を有効にしても、既存のポリシーやACLには影響しません。 trueに設定すると、次の動作が発生します。
  指定されたACLがパブリックアクセスを許可している場合、PUTバケットaclおよびPUTオブジェクトacl呼び出しは失敗します。
  リクエストにオブジェクトACLが含まれている場合、PUTオブジェクトの呼び出しは失敗します。 */
  block_public_acls = true

  /*   AmazonS3がこのバケットのパブリックバケットポリシーをブロックする必要があるかどうか。デフォルトはfalseです。
  この設定を有効にしても、既存のバケットポリシーには影響しません。 trueに設定すると、AmazonS3は次のようになります。
  指定されたバケットポリシーがパブリックアクセスを許可している場合、PUTバケットポリシーへの呼び出しを拒否します。 */
  block_public_policy = true

  /*   AmazonS3がこのバケットのパブリックACLを無視するかどうか。デフォルトはfalseです。
  この設定を有効にしても、既存のACLの永続性には影響せず、新しいパブリックACLの設定が妨げられることもありません。
   trueに設定すると、AmazonS3は次のようになります。 このバケットとそれに含まれるオブジェクトのパブリックACLは無視してください。 */
  ignore_public_acls = true

  /*   AmazonS3がこのバケットのパブリックバケットポリシーを制限する必要があるかどうか。デフォルトはfalseです。
  この設定を有効にしても、特定のアカウントへの非公開の委任を含む、公開バケットポリシー内の公開およびクロスアカウントアクセスがブロックされることを除いて、
  以前に保存されたバケットポリシーには影響しません。 trueに設定した場合： パブリックポリシーがある場合、バケットの所有者とAWSサービスのみがこのバケットにアクセスできます。 */
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "tfstate_lock" {
  name           = "${var.base_name}-tfstate-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"
  # https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html#HowItWorks.DataTypeDescriptors
  attribute {
    name = "LockID"
    type = "S"
  }

}
