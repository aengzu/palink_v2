#!/bin/sh

# 1. Flutter 웹 애플리케이션 빌드
flutter build web --web-renderer html

# 2. AWS S3 버킷에 파일 업로드
aws s3 sync ./build/web s3://palink-webapp

# 3. CloudFront 캐시 무효화
aws cloudfront create-invalidation --distribution-id EH08OF3FWDXSE --paths '/*'
