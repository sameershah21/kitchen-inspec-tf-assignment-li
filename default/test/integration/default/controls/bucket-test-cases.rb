title 'AWS S3 Buckets'

bucket_name = attribute('bucket_name')

control 's3' do
    impact 1.0

    title 'Ensure S3 bucket exists with the right tags'
    describe aws_s3_buckets('test_bucket') do
        it {should exist}
        its('tags') {should include (key: 'Audit_Date', Value: 'Feb 14 2022')}
    end

    title 'Ensure S3 bucket has an ACL'
    describe aws_s3_bucket('test_bucket') do
        its('bucket_acl.count') { should eq 1 }
    end

    title 'Check if bucket has a bucket_policy'
    describe aws_s3_bucket('test_bucket') do
        its('bucket_policy') { should be_empty }
    end

    title 'Check if bucket is exposed to public'
    describe aws_s3_bucket('test_bucket') do
        it { should_not be_public }
    end

    title 'Check if bucket has default encryption enabled '
    describe aws_s3_bucket('test_bucket') do
        it { should have_default_encryption_enabled }
    end

    title "Check if the bucket in the correct region"
    describe aws_s3_bucket('test_bucket') do
        its('region') { should eq 'us-west-2' }
    end

    bucket_acl = aws_s3_bucket('my-bucket').bucket_acl

    # Look for grants to "AllUsers" (that is, the public)
    all_users_grants = bucket_acl.select do |g|
        g.grantee.type == 'Group' && g.grantee.uri =~ /AllUsers/
    end

    # Look for grants to "AuthenticatedUsers" (that is, any authenticated AWS user - nearly public)
    auth_grants = bucket_acl.select do |g|
        g.grantee.type == 'Group' && g.grantee.uri =~ /AuthenticatedUsers/
    end


end